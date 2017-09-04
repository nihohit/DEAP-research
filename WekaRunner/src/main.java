import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Random;

import weka.core.Instances;
import weka.classifiers.AbstractClassifier;
import weka.classifiers.evaluation.Evaluation;
import weka.classifiers.functions.SMO;
import weka.classifiers.meta.AttributeSelectedClassifier;

public class main {

	public static void main(String[] args) throws Exception {
		File target = new File(args[0]);
		if (!target.exists()) {
			target.createNewFile();
		}
		FileWriter writer = new FileWriter(target);
		
		File folder = new File(args[1]);
		File[] listOfFiles = folder.listFiles();
		for (int i = 0; i < listOfFiles.length; i++) {
			File file = listOfFiles[i];
			if (file.isDirectory()) {
				continue;
			}
			String path = file.getAbsolutePath();
			String fileName = stripExtension(file.getName());
			System.out.println("processing " + (i + 1) + " of " + (listOfFiles.length + 1) + ": " + fileName);
			BufferedReader reader = new BufferedReader(new FileReader(path));
			Instances data = new Instances(reader);
			data.setClassIndex(data.numAttributes() - 1);
			reader.close();
			
			try{
			System.out.println("meta");
			String[] options = new String[]{
					 "-E", "weka.attributeSelection.InfoGainAttributeEval",
					 "-S", "weka.attributeSelection.Ranker -T -1.7976931348623157E308 -N -1",
					 "-W", "weka.classifiers.functions.SMO"
			};
			AttributeSelectedClassifier meta = new AttributeSelectedClassifier();
			meta.setOptions(options);
			writer.append(evalClassifier(meta, data, fileName, "meta"));
			}
			catch(Exception exception){}
			
			try{
			System.out.println("SMO");
			String[] options = new String[]{"-V", "10"};
			SMO smo = new SMO();
			smo.setOptions(options);
			writer.append(evalClassifier(smo, data, fileName, "SMO"));
			}
			catch(Exception exception){}
		}
		writer.close();
	}
	
	static String stripExtension (String str) {
        // Handle null case specially.
        if (str == null) return null;
        // Get position of last '.'.
        int pos = str.lastIndexOf(".");
        // If there wasn't any '.' just return the string as is.
        if (pos == -1) return str;
        // Otherwise return the string, up to the dot.
        return str.substring(0, pos);
    }
	
	static String evalClassifier(AbstractClassifier classifier, Instances data, String fileName, String classifierName) throws Exception {
		classifier.buildClassifier(data);
		Evaluation eval = new Evaluation(data);
		eval.crossValidateModel(classifier, data, 10, new Random(1));
		double successPercentage = eval.correct() / (eval.correct() + eval.incorrect()) * 100;
		fileName = fileName.replace('_', ',');
		return fileName + "," + classifierName + "," + successPercentage + "," + eval.weightedFMeasure() + "," +eval.weightedAreaUnderROC() + "\n";
	}
}
