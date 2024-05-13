import Foundation

/**
 This program reads integers from a file and calculates the sum of their digits.
 It also provides statistics such as total numbers processed, total sum of digits,
 average sum of digits, minimum sum of digits, and maximum sum of digits.
 
 Author: [Your Name]
 Since: [Date]
 Version: [Version Number]
**/

// Function to calculate the sum of digits of a number recursively
func sumOfDigits(_ someNumber: Int) -> Int {
    // Base case: if the number is a single digit, return it
    if someNumber < 10 {
        return someNumber
    }
    // Recursive case: sum the last digit with the sum of the rest of the digits
    else {
        return someNumber % 10 + sumOfDigits(someNumber / 10)
    }
}

// Check if the user has provided the input and output file names as command-line arguments
guard CommandLine.arguments.count == 3 else {
    print("Usage: ./ProgramName input_file output_file")
    exit(1)
}

// Extract the filenames from the command-line arguments
let inputFilename = CommandLine.arguments[1]
let outputFilename = CommandLine.arguments[2]

// Function to process the file
func processFile(_ inputFilename: String, _ outputFilename: String) {
    // Initialize variables to store statistics about the numbers read from the file
    var totalNumbers = 0
    var totalSum = 0
    var minSum = Int.max
    var maxSum = Int.min

    // Initialize output string
    var outputString = ""

    do {
        // Read the input file
        let fileContents = try String(contentsOfFile: inputFilename, encoding: .utf8)
        
        // Process each line in the file
        fileContents.enumerateLines { line, _ in
            // Check if the line contains a valid integer
            if let number = Int(line) {
                // Calculate the sum of digits for the current number
                totalNumbers += 1 // Increment the total number count
                let sum = sumOfDigits(abs(number)) // Calculate the sum of digits
                totalSum += sum // Add the sum to the total sum
                minSum = min(minSum, sum) // Update the minimum sum
                maxSum = max(maxSum, sum) // Update the maximum sum
                
                // Append the sum of digits to the output string, considering the sign of the original number
                if number < 0 {
                    outputString.append("Sum of digits for \(number): -\(sum)\n")
                } else {
                    outputString.append("Sum of digits for \(number): \(sum)\n")
                }
            } else {
                // Handle the case where the line does not contain a valid integer
                outputString.append("Invalid number format in line: \(line)\n")
            }
        }
        
        // Append statistics about the numbers read from the file to the output string
        outputString.append("Total numbers processed: \(totalNumbers)\n")
        outputString.append("Total sum of all digits: \(totalSum)\n")
        outputString.append("Average sum of digits: \(totalNumbers > 0 ? Double(totalSum) / Double(totalNumbers) : 0)\n")
        outputString.append("Minimum sum of digits: \(minSum == Int.max ? "N/A" : "\(minSum)")\n")
        outputString.append("Maximum sum of digits: \(maxSum == Int.min ? "N/A" : "\(maxSum)")\n")

        // Write the output string to the output file
        try outputString.write(toFile: outputFilename, atomically: true, encoding: .utf8)
        print("Output written to \(outputFilename)")
    } catch {
        // Handle the case where an error occurs while reading the file or writing to the output file
        print("Error: \(error.localizedDescription)")
    }
}

// Process the input file and write results to the output file
processFile(inputFilename, outputFilename)
