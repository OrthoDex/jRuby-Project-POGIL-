module SentenceDetector
	require 'java'
	include Java

	$CLASSPATH << '/home/ishaan/Documents/apache-opennlp-1.6.0/lib/opennlp-tools-1.6.0.jar'
	include_package 'opennlp.tools.sentdetect'

	java_import 'java.io.FileInputStream'

	begin
		modelIn = FileInputStream.new("en-sent.bin")
		model = SentenceModel.new(modelIn)
		inputFile = File.open("input.txt", "r+")

	rescue IOError
		$stderr.print "IO Failed: " + $!
		raise
	end

	sentenceDetector = SentenceDetectorME.new(model)
	
	paragraph = inputFile.read

	sentences = sentenceDetector.sentDetect(paragraph)
	outputFile = File.open("output.txt", "w")
	sentences.each { |sentence| outputFile.puts sentence }
	outputFile.close

	puts "Sentence Detection Complete"
end