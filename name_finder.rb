module SentenceDetector
	require 'java'
	include Java

	$CLASSPATH << '/home/ishaan/Documents/apache-opennlp-1.6.0/lib/opennlp-tools-1.6.0.jar'
	include_package 'opennlp.tools.namefind'

	java_import 'java.io.FileInputStream'

	begin
		modelIn = FileInputStream.new("es-ner-person.bin")
		model = SentenceModel.new(modelIn)
		inputFile = File.open("input.txt", "r+")

	rescue IOError
		$stderr.print "IO Failed: " + $!
		raise
	end

	nameFinder = NameFinderME.new(model)
	
	paragraph = inputFile.read

	sentences = nameFinder.sentDetect(paragraph)
	outputFile = File.open("output2.txt", "w")
	sentences.each { |sentence| outputFile.puts sentence }
	outputFile.close

	puts "Name Detection Complete"
end