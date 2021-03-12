# setwd("~/storage/emulated/0/Documents/documents/latex/1920-Bheng/f137/"); source("create-files-and-infos.R") 

#--
# To run this script in bash, copy this:
# cd ~/storage/emulated/0/Documents/documents/latex/1920-Bheng/f137/; Rscript create-files-and-infos.R
#--


# Load packages.
#library(readxl) 
library(openxlsx) 

# Assign the filenames. 
ExcelFile <- "ecard-infos.xlsx"

cardsDir <- "1st-grading-cards"

cardsTemplate <- "ecard-template.xlsx"

# Load the dataframe. 
cat("Loading data:", ExcelFile, "\n") 

#DF <- read_excel(ExcelFile, sheet = f137sheet, range = f137range, col_names = TRUE)
#allDF <- c("infosMaleDF", "infosFemaleDF", "firstGradesMaleDF", "firstGradesFemaleDF")
DF <- c()
sheetNames <- c("Infos-Card-Male", "Infos-Card-Female", "1st-Summary-Male", "1st-Summary-Female")

for (i in 1:4) {
	DF[[i]] <- readWorkbook(ExcelFile, sheet = sheetNames[i], startRow = 1, colNames = TRUE, rowNames = FALSE, detectDates = FALSE, skipEmptyRows = TRUE, skipEmptyCols = TRUE, rows = NULL, cols = NULL, check.names = FALSE, sep.names = ".", namedRegion = NULL, na.strings = "NA", fillMergedCells = FALSE)

	DF[[i]] <- DF[[i]][!apply(DF[[i]] == "", 1, all), ]
}

#infosMaleDF <- readWorkbook(ExcelFile, sheet = "Infos-Card-Male", startRow = 1, colNames = TRUE, rowNames = FALSE, detectDates = FALSE, skipEmptyRows = TRUE, skipEmptyCols = TRUE, rows = NULL, cols = NULL, check.names = FALSE, sep.names = ".", namedRegion = NULL, na.strings = "NA", fillMergedCells = FALSE)

#infosMaleDF <- infosMaleDF[!apply(infosMaleDF == "", 1, all), ]

#infosFemaleDF <- readWorkbook(ExcelFile, sheet = "Infos-Card-Female", startRow = 1, colNames = TRUE, rowNames = FALSE, detectDates = FALSE, skipEmptyRows = TRUE, skipEmptyCols = TRUE, rows = NULL, cols = NULL, check.names = FALSE, sep.names = ".", namedRegion = NULL, na.strings = "NA", fillMergedCells = FALSE)

#firstGradesMaleDF <- readWorkbook(ExcelFile, sheet = "1st-Summary-Male", startRow = 1, colNames = TRUE, rowNames = FALSE, detectDates = FALSE, skipEmptyRows = TRUE, skipEmptyCols = TRUE, rows = NULL, cols = NULL, check.names = FALSE, sep.names = ".", namedRegion = NULL, na.strings = "NA", fillMergedCells = FALSE)

#firstGradesFemaleDF <- readWorkbook(ExcelFile, sheet = "1st-Summary-Female", startRow = 1, colNames = TRUE, rowNames = FALSE, detectDates = FALSE, skipEmptyRows = TRUE, skipEmptyCols = TRUE, rows = NULL, cols = NULL, check.names = FALSE, sep.names = ".", namedRegion = NULL, na.strings = "NA", fillMergedCells = FALSE)



#cat("Loading cards template:", cardsTemplate, "\n") 


#print(infosMaleDF)


# Fill out infos for each excel file. 
#malesDF <- c(DF[[1]], DF[[3]])
#femalesDF <- c(DF[[2]], DF[[4]])
#infosDF <- c(DF[[1]], DF[[2]])
#firstgradesDF <- c(DF[[3]], DF[[4]])
#infosDFIndex <- c(1, 2)
firstGradesDFIndex <- c(3, 4)
#allDF <- c(malesDF, femalesDF)
#malesDF <- c(infosMaleDF, firstGradesMaleDF)
#femalesDF <- c(infosFemaleDF, firstGradesFemaleDF)

#for (i in 1:nrow(infosMaleDF)) {̨	
#for (i in 1:nrow(allDF[[1]])) {̨ 

if (dir.exists(cardsDir)) {
		cat("Directory exists:", cardsDir, "\n")
	} else {
		cat("Creating directory:", cardsDir, "\n")
		dir.create(cardsDir)
	}

#sheetsWrite <- c("Infos", "Grades")

for (h in 1:2) {
#for (h in 1:length(allDF[g])) {
for (i in 1:nrow(DF[[h]])) {
	# Create filename. 
	
	student_name <- DF[[h]]$Name[[i]]
	#student_name <- infosMaleDF$Name[[i]]
	student_name <- toupper(student_name) 

	student_code <- DF[[h]]$Code[[i]]
	#student_code <- infosMaleDF$Code[[i]]
	namefile <- paste(student_code, student_name, sep="-")
	
	new_file <- paste(namefile, "xlsx", sep=".") 
	
	cat("Creating new file:", new_file, "\n") 

	filepath <- paste(cardsDir, new_file, sep="/") 
	
	# Load template file. 
	wb <- loadWorkbook(cardsTemplate, xlsxFile = NULL, isUnzipped = FALSE)  
	
	infoRow <- DF[[h]][i, ]

	gradesRow <- DF[[firstGradesDFIndex[h]]][i, ]

	rowWrite <- c(infoRow, gradesRow)
 	
	#setwd('path')
	#for (k in 1:length(sheetsWrite)) {
	#	writeData(wb, sheetsWrite[k], rowWrite[k], startCol = 1, startRow = 2, xy = NULL, colNames = FALSE, rowNames = FALSE, headerStyle = NULL, borders = "none", withFilter = FALSE, keepNA = FALSE, na.string = NULL, name = NULL, sep = ", ")
	#}
	writeData(wb, "Infos", infoRow, startCol = 1, startRow = 2, xy = NULL, colNames = FALSE, rowNames = FALSE, headerStyle = NULL, borders = "none", withFilter = FALSE, keepNA = FALSE, na.string = NULL, name = NULL, sep = ", ")
	
	writeData(wb, "Grades", gradesRow, startCol = 1, startRow = 2, xy = NULL, colNames = FALSE, rowNames = FALSE, headerStyle = NULL, borders = "none", withFilter = FALSE, keepNA = FALSE, na.string = NULL, name = NULL, sep = ", ")
#	writeDataTable(wb, "Infos", infoRow, startCol = 1, startRow = 2, xy = NULL, colNames = FALSE, rowNames = FALSE, withFilter = FALSE, keepNA = FALSE, na.string = NULL)

#	showGridLines(wb, "Card", showGridLines = TRUE)

	saveWorkbook(wb, filepath, overwrite = TRUE, returnValue = FALSE)
	#sheets <- getSheets(wb)
	#sheets <- getSheetNames(template)	

	#sheet <- sheets[["Front"]]
	#sheet <- sheets["Infos"] 
	
	#rows  <- getRows(sheet)
		
	# Fill out infos. 
	#cat("Filling out infos.\n")  
	#for (j in 1:length(colIndexes)) {
	#	k <- j + 1
	#	l <- rowIndexes[[j]]
	#	if (toString(DF[i,k]) != "NA" ) {
    	#	cell <- getCells(rows, colIndex = colIndexes[[j]])  	
	#		setCellValue(cell[[l]], value = toString(DF[i,k]))	
	#	}
	#}
	#cat("Saving file.\n")  
	#saveWorkbook(wb, file = file_name)
}
}


