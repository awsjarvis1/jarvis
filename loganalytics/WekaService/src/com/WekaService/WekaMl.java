package com.WekaService;
/*
 * Load model and predict on test data
 */

/**
 *
 * @author Sanket
 */
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;

import org.json.simple.JSONObject;

import weka.classifiers.bayes.NaiveBayes;
import weka.classifiers.meta.FilteredClassifier;
import weka.core.Instances;

public class WekaMl {


	// Reads the input file for test data
	public static BufferedReader readDataFile(String filename) {
		BufferedReader inputReader = null;

		try {
			inputReader = new BufferedReader(new FileReader(filename));
		} catch (FileNotFoundException ex) {
			System.err.println("File not found: " + filename);
		}

		return inputReader;
	}

	public static void main(String[] args) throws Exception {

		String path1 = WekaMl.class.getProtectionDomain().getCodeSource().getLocation().getPath();

		File filePath = new File(path1);
		
		String parentFilePath = filePath.getParent();

		//check the correct argument number
		if(args.length < 3){
			System.err.println("Incorrect number of arguments");
			return;
		}

		// Read the test data and decide the classifier attribute
		BufferedReader testfilereader = readDataFile(args[0]);

		Instances testdata = new Instances(testfilereader);
		testfilereader.close();
		testdata.setClassIndex(testdata.numAttributes() - 1);

		// Create copy of the test set
		Instances testdatacopy = new Instances(testdata);
		JSONObject jsonObj = new JSONObject();

		if ("DriveHealth".equals(args[1])){
			
			// Delete string attribute
			testdata.deleteStringAttributes();

			// Load a model
			NaiveBayes NB = new NaiveBayes();
			NB = (NaiveBayes)weka.core.SerializationHelper.read(parentFilePath + File.separator + "EMCDrive.model");


			// Classify the instance using the classifier and predict the value
			for (int i = 0; i < testdata.numInstances(); i++) {
				double pred = NB.classifyInstance(testdata.instance(i));
				jsonObj.put(testdatacopy.instance(i).attribute(0).value(i), testdata.classAttribute().value((int) pred));
			}


		} else if("LogAnalytics".equals(args[1])) {

			// Load a model
			FilteredClassifier FC = new FilteredClassifier();
			FC = (FilteredClassifier)weka.core.SerializationHelper.read(parentFilePath + File.separator + "EMCLog.model");

			// Classify the instance using the classifier and predict the value
			for (int i = 0; i < testdata.numInstances(); i++) {
				double pred = FC.classifyInstance(testdata.instance(i));
				jsonObj.put(i, testdata.classAttribute().value((int) pred));
			}
		}else{
			System.out.println("Option not available");
		}

		/*try{

			Path path = Paths.get( parentFilePath + File.separator +args[2] + File.separator +"wekaoutput");
			Files.write(path,jsonObj.toJSONString().getBytes() );

		}catch(IOException e){
			System.err.println("Cannot create a file: " + e.getMessage());
		}*/
		
		System.out.println(jsonObj.toJSONString());

	}
}
