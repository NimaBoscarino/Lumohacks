# this file executes the model on an input tsv
# and outputs the most likely diagnosis with
# corresponding probability

library(glmnet)

# specify path to model if not in current dir
model.filepath = './cancer_guesser.RData'

# load model
load(model.filepath)

# get input

# enable cmd line args
args <- commandArgs(TRUE)                # use cmd line args
input.file <- args[1]        # first arg is path to input file
print(input.file)
input <- read.delim(input.file, sep = '\t', header = T, stringsAsFactors = F)

results <- data.frame(predict(model,as.matrix(input[3:ncol(input)]),
                              type="response",s=0),stringsAsFactors=F)

predicted.type <- gsub('[.].*', '', colnames(results)[which.max(results)])
probability <- round(max(results) * 100,1)

# map cancer type to acronym
mapper <- data.frame(cbind(acronym = unique(names(model$beta)),
                full.name = c("Adrenocorticoid Carcinoma",
                              "Bladder Uterothelial Carcinoma",
                              "Breast Invasive Carcinoma",
                              "Cervical Squamous Cell Carcinoma",
                              "Cholangio Carcinoma",
                              "Colon Adenocarcinoma",
                              "Diffuse Large B-Cell Carcinoma",
                              "Esophageal Carcinoma",
                              "Gliobastoma Multiforme",
                              "Non-cancerous (healthy)",
                              "Head/Neck Squamous Cell Carcinoma",
                              "Kidney Chromophobe",
                              "Kidney Renal Clear Cell Carcinoma",
                              "Kidney Renal Papillary Cell Carcinoma",
                              "Acute Myeloid Leukemia",
                              "Brain Lower Grade Glioma",
                              "Liver Hepatocellular Carcinoma",
                              "Lung Adenocarcinoma",
                              "Lung Squamous Cell Carcinoma",
                              "Mesothelialoma",
                              "Ovarian Cystadenocarcinoma",
                              "Pancreatic Adenocarcinoma",
                              "Pheochromocytoma and Paraganglioma",
                              "Prostate Adenocarcinoma",
                              "Rectum Adenocarcinoma",
                              "Sarcoma",
                              "Skin Cutaneous Melanoma",
                              "Stomach Adenocarcinoma",
                              "Testicular Germ-cell Tumor",
                              "Thyroid Carcinoma",
                              "Thymoma",
                              "Uterine Corpus Endometrial Carcinoma",
                              "Uterine Carcinosarcoma",
                              "Uveal melanoma")), stringsAsFactors = F)
                  
# order results
results<-sort(results, decreasing = T)
colnames(results)<-gsub('[.].*','',colnames(results))
rownames(results)<-NULL
results2<-data.frame(cbind(Type=colnames(results),t(unname(results))),stringsAsFactors = F)
colnames(results2)[2]<-"Probability"
results2[,1]<-mapper$full.name[match(results2[,1],mapper$acronym)]

write.table(results2, file = './output.csv', sep = ",", row.names = F, col.names = F)

# print to standard out
for (i in 1:ncol(results)){
print(paste(mapper$full.name[mapper$acronym == gsub('[.].*', '', colnames(results)[i])],
      round((results[i]*100),4), sep = ","))
}
