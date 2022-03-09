#library(rsconnect)
#rsconnect::setAccountInfo(name='anayana',
#                          token='D73FB341C4BEBA61E4D58E1006E9DF69',
#                          secret='IL+3D1S2qXIGHbEnZkcUn2nWotcz+jKw7VMza9Vu')
#rsconnect::deployApp('C:/Users/angel.naya-geiger/Desktop/2021js_Optaklim_Mila/MiLApp/')



library(shiny)
#library(tidyverse)
library(dplyr)
library(tibble)
library(data.table)
library(RCurl)
 
# Set working directory
wd <- "C:\\Users\\angel.naya-geiger\\Desktop\\2021js_Optaklim_Mila\\"
setwd(wd)

#Ein <- read.csv2("MiLA_Ein.csv")
Ein <- read.csv2("https://raw.githubusercontent.com/anayana/MiLApp/main/data/MiLA_Ein.csv", sep=";", fileEncoding = "latin1")
head(Ein)

#Kul <- read.csv2("MiLA_Kul.csv")
Kul <- read.csv2("https://raw.githubusercontent.com/anayana/MiLApp/main/data/MiLA_Kul.csv", sep=";", fileEncoding = "latin1") 
head(Kul)

#Tec <- read.csv2("MiLA_Tec.csv")
Tec <- read.csv2("https://raw.githubusercontent.com/anayana/MiLApp/main/data/MiLA_Tec.csv", sep=";", fileEncoding = "latin1") 
head(Tec)

#FZ <- read.csv2("MiLA_FZ.csv")
FZ <- read.csv2("https://raw.githubusercontent.com/anayana/MiLApp/main/data/MiLA_FZ.csv", sep=";", fileEncoding = "latin1") 
head(FZ)

#Dun <- read.csv2("MiLA_Dun.csv")
Dun <- read.csv2("https://raw.githubusercontent.com/anayana/MiLApp/main/data/MiLA_Dun.csv", sep=";", fileEncoding = "latin1") 
Dun[is.na(Dun)] <- 0
head(Dun)

#DuEi <- read.csv2("MiLA_DuEi.csv")
DuEi <- read.csv2("https://raw.githubusercontent.com/anayana/MiLApp/main/data/MiLA_DuEi.csv", sep=";", fileEncoding = "latin1") 
head(DuEi)

FEm <- Dun[,c(1:3, 6, 8:9, 14:16)]
FEm[is.na(FEm)] <- 0
head(FEm)
nrow(FEm)

#End <- read.csv2("MiLA_End.csv")
End <- read.csv2("https://raw.githubusercontent.com/anayana/MiLApp/main/data/MiLA_End.csv", sep=";", fileEncoding = "latin1") 
head(End)

#Kli <- read.csv2("MiLA_Kli.csv")
Kli <- read.csv2("https://raw.githubusercontent.com/anayana/MiLApp/main/data/MiLA_Kli.csv", sep=";", fileEncoding = "latin1") 
head(Kli)

SoN <- read.csv2("MiLA_SoilN.csv")
SoN <- read.csv2("https://raw.githubusercontent.com/anayana/MiLApp/main/data/MiLA_SoilN.csv", sep=";", fileEncoding = "latin1") 
head(SoN)

#AuT <- read.csv2("MiLA_AuT.csv")
AuT <- read.csv2("https://raw.githubusercontent.com/anayana/MiLApp/main/data/MiLA_AuT.csv", sep=";", fileEncoding = "latin1") 
head(AuT)



#pH <- read.csv2("MiLA_pH.csv")
pH <- read.csv2("https://raw.githubusercontent.com/anayana/MiLApp/main/data/MiLA_pH.csv", sep=";", fileEncoding = "latin1") 
head(pH)

#BoT <- read.csv2("MiLA_BoT.csv")
BoT <- read.csv2("https://raw.githubusercontent.com/anayana/MiLApp/main/data/MiLA_BoT.csv", sep=";", fileEncoding = "latin1") 
head(BoT)

#SOC <- read.csv2("MiLA_SOC.csv")
SOC <- read.csv2("https://raw.githubusercontent.com/anayana/MiLApp/main/data/MiLA_SOC.csv", sep=";", fileEncoding = "latin1") 
head(SOC)

#KAK <- read.csv2("MiLA_KAK.csv")
KAK <- read.csv2("https://raw.githubusercontent.com/anayana/MiLApp/main/data/MiLA_KAK.csv", sep=";", fileEncoding = "latin1") 
head(KAK)

#Fak <- read.csv2("MiLA_Fak.csv") 
Fak <- read.csv2("https://raw.githubusercontent.com/anayana/MiLApp/main/data/MiLA_Fak.csv", sep=";", fileEncoding = "latin1") 
head(Fak)

DX1 <- "m3/ha"
DX2 <- "l/ha"




## Only run examples in interactive R sessions

    

    
    # demoing group support in the `choices` arg
    shinyApp(
        ui = fluidPage(

                titlePanel("Shiny MiLApp"),
                
                sidebarPanel(
                    tabsetPanel(type = "tabs",
                    
                                tabPanel("Fruchtfolge",
                                        selectInput("Fruchtfolgeglied", "Fruchtfolgeglied", 1:10),
                                        numericInput("Menge", "Menge", 500, 0, 1000),
                                        selectInput("Frucht", "Frucht", Kul$Fruchtart),
                                        selectInput("Düngemittel", "Düngemittel", FEm$Bezeichnung),
                                        selectInput("Anzahl anzurechnender Fruchtfolgeglieder", "Anzahl anzurechnender Fruchtfolgeglieder", 1:10),
                                        selectInput("Ausbringungstechnik", "Ausbringungstechnik", Tec$Ausbringungstechnik),
                                        numericInput("Temp", "Temp.bei Ausbringung in C", 20, 0, 40)
                                        ),
                                
                                tabPanel("Standort",
                                         selectInput("Klima", "Klima", Kli$Auswahl),
                                         selectInput("Auswaschungsgefahr", "Auswaschungsgefahr", choices=c("ja", "nein"))
                                        ),
                                
                                tabPanel("Boden",
                                         selectInput("Schlagnummer", "Schlagnummer", 1:10),
                                         selectInput("Bodentextur", "Bodentextur", BoT$Bodentextur),
                                         selectInput("SoilN", "SoilN", SoN$Auswahl),
                                         selectInput("SOC", "SOC", SOC$SOC),
                                        selectInput("pH", "pH", pH$pH.Wert)
                                        )
                                ),
                        width = 4
                            ),
                
                mainPanel(
                    tabsetPanel(type = "tabs",
                                tabPanel("Ergebnisse",
                                         
                                        h4("Ergebnisse"),
                                        tableOutput("Ergebnisse"),
                                        
                                        h4("Feldemissionen"),
                                        tableOutput("Feldemissionen")
                                        
                                        
                                    ),
                    
                                tabPanel("Zwischenergebnisse",
                                             
                                             h4("Feldemissionen_CO2"),
                                             tableOutput("Feldemissionen_CO2"),
                                             
                                             h4("Düngerherstellung_CO2"),
                                             tableOutput("Düngerherstellung_CO2"),
                                             
                                             h4("Düngerherstellung_KEA"),
                                             tableOutput("Düngerherstellung_KEA"),
                                            
                                        h6("HB13"),
                                        tableOutput("HB13"),
                                        
                                        h6("GH13"),
                                        tableOutput("GH13"),
                                        
                                        h6("EQ13"),
                                        tableOutput("EQ13"),
                                        
                                        h6("IP13"),
                                        tableOutput("IP13"),
                                        
                                        h6("IF13"),
                                        tableOutput("IF13"),
                                        
                                        h6("IZ13"),
                                        tableOutput("IZ13"),
                                        
                                        h6("GR13"),
                                        tableOutput("GR13"),
                                        
                                        h6("KN13"),
                                        tableOutput("KN13"),
                                        
                                        h6("KD13"),
                                        tableOutput("KD13"),
                                        
                                        h6("JJ13"),
                                        tableOutput("JJ13"),
                                        
                                        h6("HL13"),
                                        tableOutput("HL13")
                                        
                                    ),
                                
                                tabPanel("Basisdaten",
                                         
                                         h4("Faktoren"),
                                         
                                         h6("FD1"),
                                         tableOutput("FD1"),
                                         
                                         h6("FE1"),
                                         tableOutput("FE1"),
                                         
                                         
                                         h4("Input"),
                                         
                                         h6("I13"),
                                         tableOutput("I13"),
                                         
                                         h6("M13"),
                                         tableOutput("M13"),
                                         
                                         
                                         h4("Standort"),
                                         
                                         h6("Schluff"),
                                         tableOutput("Schluff"),
                                         
                                         h6("Ton"),
                                         tableOutput("Ton"),
                                         
                                         h6("R13"),
                                         tableOutput("R13"),
                                         
                                         h6("S13"),
                                         tableOutput("S13"),
                                         
                                         h6("T13"),
                                         tableOutput("T13"),
                                         
                                         h6("U13"),
                                         tableOutput("U13"),
                                         
                                         
                                         h4("Dünger"),
                                         
                                         h6("FD13"),
                                         tableOutput("FD13"),
                                         
                                         h6("EH13"),
                                         tableOutput("EH13"),
                                         
                                         h6("EK13"),
                                         tableOutput("EK13"),
                                         
                                         h6("EO13"),
                                         tableOutput("EO13"),
                                         
                                         h6("ER13"),
                                         tableOutput("ER13"),
                                         
                                         h6("Q13"),
                                         tableOutput("Q13"),
                                         
                                         h6("P13"),
                                         tableOutput("P13"),
                                         
                                         h6("EN13"),
                                         tableOutput("EN13"),
                                         
                                         h6("EM13"),
                                         tableOutput("EM13"),
                                         
                                         h6("FN13"),
                                         tableOutput("FN13"),
                                         
                                         h6("HV13"),
                                         tableOutput("HV13"),
                                         
                                         h6("O13"),
                                         tableOutput("O13"),
                                         
                                         h6("fest"),
                                         tableOutput("fest"),
                                         
                                         h6("flüssig"),
                                         tableOutput("flüssig"),
                                         
                                         h6("L13"),
                                         tableOutput("L13"),
                                         
                                         h6("ES13"),
                                         tableOutput("ES13"),
                                         
                                         h6("pH_Mean"),
                                         tableOutput("pH_Mean"),
                                         
                                         h6("J13"),
                                         tableOutput("J13"),
                                         
                                         h6("EJ13"),
                                         tableOutput("EJ13"),
                                         
                                         h6("EI13"),
                                         tableOutput("EI13"),
                                         
                                         h6("FX13"),
                                         tableOutput("FX13"),
                                         
                                         h6("EP13"),
                                         tableOutput("EP13"),
                                         
                                         h6("Dichte"),
                                         tableOutput("Dichte"),
                                         
                                         h6("Einheit"),
                                         tableOutput("Einheit"),
                                         
                                         h6("N13"),
                                         tableOutput("N13"),
                                         
                                         
                                         
                                         h6("AF13"),
                                         tableOutput("AF13"),
                                         
                                         h6("V13"),
                                         tableOutput("V13"),
                                         
                                         
                                         h6("F_AE13"),
                                         tableOutput("F_AE13"),
                                         
                                         h6("F_Q13"),
                                         tableOutput("F_Q13")
                                         
                                         
                                    )
                                )
                )
            ),
        
        
        server = function(input, output) {
            
            output$Feldemissionen <- renderTable({
                FEm[c(3:9)] %>% 
                    dplyr::filter(Bezeichnung == input$Düngemittel) %>% 
                    rename(N = Nges_PrzFM,
                           NH4N = NH4_N_PrzFM,
                           Harnstoff = Harnstoff_N_PrzFM,
                           P2O5 = P2O5_PrzFM,
                           K2O = K2O_PrzFM,
                           CaCO3 = CaCO3_PRZFM
                    )
            })   
            
            output$Ergebnisse <- renderTable({
                data.table(Düngerherstellung_CO2 = Düngerherstellung_CO2()[,1],
                           Düngerherstellung_KEA = Düngerherstellung_KEA()[,1],
                           Feldemissionen_CO2 = Feldemissionen_CO2()[,1])
            })
            
            
            #=SVERWEIS(H13;F_Dünger!$C:$AE;29;FALSCH)*WENN(J13=$DX$2;SVERWEIS(H13;F_Dünger!$C:$R;16;FALSCH)*I13;WENN(J13=$DX$1;I13*1000;I13))
            
            Düngerherstellung_KEA <- reactive({
                if (Einheit() == DX2) {
                    F_AE13() * Dichte() * I13()
                } else if (Einheit() == DX1){
                    F_AE13() * I13() * 1000
                } else {
                    F_AE13() * I13()    
                }
            })
            output$Düngerherstellung_KEA <- renderTable({
                if (Einheit() == DX2) {
                    F_AE13() * Dichte() * I13()
                } else if (Einheit() == DX1){
                    F_AE13() * I13() * 1000
                } else {
                    F_AE13() * I13()    
                }
            })
            
            F_AE13 <- reactive({ 
                Dun[c(3, 31)] %>% 
                    dplyr::filter(Bezeichnung   == input$Düngemittel) %>% 
                    select(Summe.KEA_Dünger..MJ.kg.Dünger.)
            })
            output$F_AE13 <- renderTable({ 
                Dun[c(3, 31)] %>% 
                    dplyr::filter(Bezeichnung   == input$Düngemittel) %>% 
                    select(Summe.KEA_Dünger..MJ.kg.Dünger.)
            })
            
            ###
            
            Düngerherstellung_CO2 <- reactive({
                if (Einheit() == DX2) {
                    F_Q13() * Dichte() * I13()
                } else if (Einheit() == DX1){
                    F_Q13() * I13() * 1000
                } else {
                    F_Q13() * I13()    
                }
            })
            output$Düngerherstellung_CO2 <- renderTable({
                if (Einheit() == DX2) {
                    F_Q13() * Dichte() * I13()
                } else if (Einheit() == DX1){
                    F_Q13() * I13() * 1000
                } else {
                    F_Q13() * I13()    
                }
            })
            
            F_Q13 <- reactive({ 
                Dun[c(3, 17)] %>% 
                    dplyr::filter(Bezeichnung   == input$Düngemittel) %>% 
                    select(THG_Faktor)
            })
            output$F_Q13 <- renderTable({ 
                Dun[c(3, 17)] %>% 
                    dplyr::filter(Bezeichnung   == input$Düngemittel) %>% 
                    select(THG_Faktor)
            })
            
            ###
            
            Feldemissionen_CO2 <- reactive({
                #=(((((IZ13+GR13)*0,01)+HL13+JJ13)*(44/28))*298)+KD13+KN13
                #(((((IZ13() + GR13()[,1]) * 0.01) + HL13()[,1] + JJ13()[,1] * (44 / 28)) * 298) + KD13()[,1] + KN13()[,1])
                (((((IZ13() + GR13()) * 0.01) + HL13() + JJ13()) * (44 / 28)) * 298) + KD13() + KN13()
            })
            output$Feldemissionen_CO2 <- renderTable({
                #=(((((IZ13+GR13)*0,01)+HL13+JJ13)*(44/28))*298)+KD13+KN13
                #(((((IZ13() + GR13()[,1]) * 0.01) + HL13()[,1] + JJ13()[,1] * (44 / 28)) * 298) + KD13()[,1] + KN13()[,1])
                (((((IZ13() + GR13()) * 0.01) + HL13() + JJ13()) * (44 / 28)) * 298) + KD13() + KN13()
            })
            
            HL13 <- reactive({ 
                #=WENN(GH13<>0;EXP($FD$1+((GH13-GR13-IZ13)*FD13)+$EH13+$EJ13+$EK13+$EO13+$ER13);0)
                if (GH13()[,1] != 0) {
                    exp(FD1[,1] + ((GH13()[,1] - GR13() - IZ13()) * FD13()[,1]) + EH13()[,1] + EJ13()[,1] + EK13()[,1] + EO13()[,1] + ER13()[,1])
                } 
                else {
                    0
                }
            })
            output$HL13 <- renderTable({
                if (GH13()[,1] != 0) {
                    exp(FD1[,1] + ((GH13()[,1] - GR13() - IZ13()) * FD13()[,1]) + EH13()[,1] + EJ13()[,1] + EK13()[,1] + EO13()[,1] + ER13()[,1])
                } 
                else {
                    0
                }
            })
            
            JJ13 <- reactive({ 
                if (input$Auswaschungsgefahr == "ja" ) {
                    (GH13()[,1] - (GH13()[,1] * 0.07) - HL13() - GR13() - HB13()) * 0.3 * 0.0075
                } else  {0} 
            })
            output$JJ13 <- renderTable({
                if (input$Auswaschungsgefahr == "ja" ) {
                    (GH13()[,1] - (GH13()[,1] * 0.07) - HL13() - GR13() - HB13()) * 0.3 * 0.0075
                } else  {0} 
            })
            
            KD13 <- reactive({ 
                # KD13...    
                ((input$Menge * Q13() / 100) * 0.12) * (44 / 12)
            })
            output$KD13 <- renderTable({
                ((input$Menge * Q13() / 100) * 0.12) * (44 / 12)
            })
            
            KN13 <- reactive({ 
                # KN13 : Harnstoff CO2-Emission kg CO2/ha =((($I13*$P13/100)*100/46,6423576)*0,2)*(44/12)
                (((input$Menge * P13() / 100) * 100 / 46.6423576) * 0.2) * (44 / 12)
            })
            output$KN13 <- renderTable({
                (((input$Menge * P13() / 100) * 100 / 46.6423576) * 0.2) * (44 / 12)
            })
        
            
            GR13 <- reactive({ 
                # GR13 : NO-N =WENN(GH13<>0;EXP($FE$1+(GH13*FN13)+$EN13+$EM13);0) 
                
                if (GH13() != 0) {
                    exp ( FE1[,1] + (GH13() * FN13()) + EN13() + EM13() )
                } 
                else {
                    0
                } 
            })
            output$GR13 <- renderTable({
                if (GH13() != 0) {
                    exp ( FE1[,1] + (GH13() * FN13()) + EN13() + EM13() )
                } 
                else {
                    0
                } 
            })
           
            
            IP13 <- reactive({ 
                IP13.1() * O13() / 100 * IF13() * IP13.2() *(14/17)
            })
            output$IP13 <- renderTable({
                IP13.1() * O13() / 100 * IF13() * IP13.2() *(14/17)
            })
            
            
            
            IZ13 <- reactive({ 
                if (AF13() == 2) {HB13()} else {IP13()}
            })
            output$IZ13 <- renderTable({
                if (AF13() == 2) {HB13()} else {IP13()}
            })
            
            IF13 <- reactive({
                if (HV13()[,1] == 0.4 & M13() < 10) {
                    0.3
                } else if (HV13()[,1] == 0.4 & M13() >= 10 & M13() < 15) {
                    0.4
                } else if (HV13()[,1] == 0.4 & M13() >= 15 & M13() < 25) {
                    0.5
                } else if (HV13()[,1] == 0.4 & M13() >= 25 & M13() < 40) {
                    0.9
                } else if (HV13()[,1] == 0.2 & M13() < 10) {
                    0.1
                } else if (HV13()[,1] == 0.2 & M13() >= 10 & M13() < 15) {
                    0.2
                } else if (HV13()[,1] == 0.2 & M13() >= 15 & M13() < 25) {
                    0.25
                } else if (HV13()[,1] == 0.2 & M13() >= 25 & M13() < 40) {
                    0.7
                } else {
                    0.9
                }
            })
            output$IF13 <- renderTable({
                if (HV13()[,1] == 0.4 & M13() < 10) {
                    0.3
                } else if (HV13()[,1] == 0.4 & M13() >= 10 & M13() < 15) {
                    0.4
                } else if (HV13()[,1] == 0.4 & M13() >= 15 & M13() < 25) {
                    0.5
                } else if (HV13()[,1] == 0.4 & M13() >= 25 & M13() < 40) {
                    0.9
                } else if (HV13()[,1] == 0.2 & M13() < 10) {
                    0.1
                } else if (HV13()[,1] == 0.2 & M13() >= 10 & M13() < 15) {
                    0.2
                } else if (HV13()[,1] == 0.2 & M13() >= 15 & M13() < 25) {
                    0.25
                } else if (HV13()[,1] == 0.2 & M13() >= 25 & M13() < 40) {
                    0.7
                } else {
                    0.9
                }
            })
            
            IP13.1 <- reactive({
                if (Einheit() == DX2) {
                    Dichte() * I13()
                } else if (Einheit() == DX1){
                    I13() * 1000
                } else {
                    I13()    
                }
            })
            output$IP13.1 <- renderTable({
                if (Einheit() == DX2) {
                    Dichte() * I13()
                } else if (Einheit() == DX1){
                    I13() * 1000
                } else {
                    I13()    
                }
            })
            
            IP13.2 <- reactive({
                if (V13() == 0.4) {
                    fest()
                } else {    
                    flüssig()
                }
            })
            output$IP13.2 <- renderTable({
                if (V13() == 0.4) {
                    fest()
                } else {    
                    flüssig()
                }
            })
            
            
            EQ13 <- reactive({ 
                if (U13() <= 16 ) {
                    KAK$NH3.KAK.FAKTOR[1]
                } else if (U13() > 16 & U13() <= 24){
                    KAK$NH3.KAK.FAKTOR[2]
                } else if (U13() > 24 & U13() <= 32){
                    KAK$NH3.KAK.FAKTOR[3]
                } else if (U13() > 32){
                    KAK$NH3.KAK.FAKTOR[4]
                } 
            })
            output$EQ13 <- renderTable({
                if (U13() <= 16 ) {
                    KAK$NH3.KAK.FAKTOR[1]
                } else if (U13() > 16 & U13() <= 24){
                    KAK$NH3.KAK.FAKTOR[2]
                } else if (U13() > 24 & U13() <= 32){
                    KAK$NH3.KAK.FAKTOR[3]
                } else if (U13() > 32){
                    KAK$NH3.KAK.FAKTOR[4]
                } 
            })
            
            GH13 <- reactive({ 
                if (Einheit() == DX2) {
                    Dichte() * I13() * N13() / 100
                } else if (Einheit() == DX1){
                    I13() * 1000  * N13() / 100
                } else {
                    I13() * N13() / 100
                }
            })
            output$GH13 <- renderTable({
                if (nrow(GH13()) > 0 ) return(GH13()) else return("NA")
            })
            
            
            HB13 <- reactive({
                GH13()[,1] * exp(EI13()[,1] + FX13()[,1] + EP13()[,1] + EQ13() + ES13()[,1] + L13()[,1])
            })
            output$HB13 <- renderTable({
                GH13()[,1] * exp(EI13()[,1] + FX13()[,1] + EP13()[,1] + EQ13() + ES13()[,1] + L13()[,1])
            })
            
            FD1 <- Fak %>% select(FD1)
            output$FD1 <- renderTable({Fak %>% select(FD1)})
            
            FE1 <- Fak %>% select(FE1)
            output$FE1 <- renderTable({Fak %>% select(FE1)})
            
            I13 <- reactive({
                input$Menge
            })
            output$I13 <- renderTable({
                input$Menge
            })
            
            M13 <- reactive({
                input$Temp
            })
            output$M13 <- renderTable({
                input$Temp
            })
            
            R13 <- reactive({ 
                if (pH_Mean() == 5.0) {
                    0.4
                } else if (pH_Mean() == 6.4){
                    0.6
                } else if (pH_Mean() == 7.9){
                    0.8
                } else if (pH_Mean() == 9){
                    1
                }
            })
            output$R13 <- renderTable({
                if (pH_Mean() == 5.0) {
                    0.4
                } else if (pH_Mean() == 6.4){
                    0.6
                } else if (pH_Mean() == 7.9){
                    0.8
                } else if (pH_Mean() == 9){
                    1
                }
            })
            
            S13 <- reactive({ 
                ((Ton() * 0.5) + (Schluff() * 0.05))
            })
            output$S13 <- renderTable({
                ((Ton() * 0.5) + (Schluff() * 0.05))
            })
            
            T13 <- reactive({ 
                J13() * 1.72 * 2
            })
            output$T13 <- renderTable({
                J13() * 1.72 * 2
            })
            
            U13 <- reactive({ 
                (T13() * R13()) + S13()
            })
            output$U13 <- renderTable({
                (T13() * R13()) + S13()
            })
            
            Schluff <- reactive({ 
                BoT[c(1, 6)] %>% 
                    dplyr::filter(Bodentextur  == input$Bodentextur) %>% 
                    select(Schluffgehalt)
            })
            output$Schluff <- renderTable({
                BoT[c(1, 6)] %>% 
                    dplyr::filter(Bodentextur  == input$Bodentextur) %>% 
                    select(Schluffgehalt)
            })
            
            Ton <- reactive({ 
                BoT[c(1, 5)] %>% 
                    dplyr::filter(Bodentextur  == input$Bodentextur) %>% 
                    select(Tongehalt)
            })
            output$Ton <- renderTable({
                BoT[c(1, 5)] %>% 
                    dplyr::filter(Bodentextur  == input$Bodentextur) %>% 
                    select(Tongehalt)
            })
            
            FD13 <- reactive({
                Dun[c(3, 19)] %>% 
                    dplyr::filter(Bezeichnung == input$Düngemittel) %>% 
                    select(Feldemission.N2O.Faktor)
            })
            output$FD13 <- renderTable({
                Dun[c(3, 19)] %>% 
                    dplyr::filter(Bezeichnung == input$Düngemittel) %>% 
                    select(Feldemission.N2O.Faktor)
            })
            
            EH13 <- reactive({
                Dun[c(34, 36)] %>% 
                    dplyr::filter(Frucht == input$Frucht) %>% 
                    select(Fruchtart.Faktor.N2O)
            })
            output$EH13 <- renderTable({
                Dun[c(34, 36)] %>% 
                    dplyr::filter(Frucht == input$Frucht) %>% 
                    select(Fruchtart.Faktor.N2O)
            })
            
            EK13 <- reactive({
                SOC[c(1, 4)] %>% 
                    dplyr::filter(SOC == input$SOC) %>% 
                    select(N2O.SOC.Faktor)
            })
            output$EK13 <- renderTable({
                SOC[c(1, 4)] %>% 
                    dplyr::filter(SOC == input$SOC) %>% 
                    select(N2O.SOC.Faktor)
            })
            
            EO13 <- reactive({
                pH[c(1, 3)] %>% 
                    dplyr::filter(pH.Wert == input$pH) %>% 
                    select(N2O.pH.Wert.Faktor)
            })
            output$EO13 <- renderTable({
                pH[c(1, 3)] %>% 
                    dplyr::filter(pH.Wert == input$pH) %>% 
                    select(N2O.pH.Wert.Faktor)
            })
            
            ER13 <- reactive({
                Kli[c(1, 4)] %>% 
                    dplyr::filter(Auswahl == input$Klima) %>% 
                    select(NO.Klima.Faktor)
            })
            output$ER13 <- renderTable({
                Kli[c(1, 4)] %>% 
                    dplyr::filter(Auswahl == input$Klima) %>% 
                    select(NO.Klima.Faktor)
            })
            
            Q13 <- reactive({ 
                Dun[c(3, 16)] %>% 
                    dplyr::filter(Bezeichnung == input$Düngemittel) %>% 
                    select(CaCO3_PRZFM)
            })
            output$Q13 <- renderTable({
                Dun[c(3, 16)] %>% 
                    dplyr::filter(Bezeichnung == input$Düngemittel) %>% 
                    select(CaCO3_PRZFM)
            })
            
            P13 <- reactive({ 
                Dun[c(3, 9)] %>% 
                    dplyr::filter(Bezeichnung == input$Düngemittel) %>% 
                    select(Harnstoff_N_PrzFM)
            })
            output$P13 <- renderTable({
                Dun[c(3, 9)] %>% 
                    dplyr::filter(Bezeichnung == input$Düngemittel) %>% 
                    select(Harnstoff_N_PrzFM)
            })
            
            EN13 <- reactive({
                SoN[c(1, 3, 5)] %>% 
                    dplyr::filter(Auswahl == input$SoilN) %>% 
                    select(NO.SOC.Faktor)
            })
            output$EN13 <- renderTable({
                SoN[c(1, 3, 5)] %>% 
                    dplyr::filter(Auswahl == input$SoilN) %>% 
                    select(NO.SOC.Faktor)
            })
            
            EM13 <- reactive({
                Kli[c(1, 4)] %>% 
                    dplyr::filter(Auswahl == input$Klima) %>% 
                    select(NO.Klima.Faktor)
            })
            output$EM13 <- renderTable({
                Kli[c(1, 4)] %>% 
                    dplyr::filter(Auswahl == input$Klima) %>% 
                    select(NO.Klima.Faktor)
            })
            
            AF13 <- reactive({ 
                Dun[c(2, 3)] %>% 
                    dplyr::filter(Bezeichnung == input$Düngemittel) %>% 
                    select(ID_DüngerArt )
            })
            output$AF13 <- renderTable({
                Dun[c(2, 3)] %>% 
                    dplyr::filter(Bezeichnung == input$Düngemittel) %>% 
                    select(ID_DüngerArt )
            })
            
            FN13 <- reactive({
                Dun[c(3, 20)] %>% 
                    dplyr::filter(Bezeichnung == input$Düngemittel) %>% 
                    select(Feldemission.NO.Faktor)
            })
            output$FN13 <- renderTable({
                Dun[c(3, 20)] %>% 
                    dplyr::filter(Bezeichnung == input$Düngemittel) %>% 
                    select(Feldemission.NO.Faktor)
            })
            
            HV13 <- reactive({
                Dun[c(3, 22)] %>% 
                    dplyr::filter(Bezeichnung == input$Düngemittel) %>% 
                    select(Feldemission.organisch.NH3.Faktor)
            })
            output$HV13 <- renderTable({
                Dun[c(3, 22)] %>% 
                    dplyr::filter(Bezeichnung == input$Düngemittel) %>% 
                    select(Feldemission.organisch.NH3.Faktor)
            })
            
            O13 <- reactive({
                Dun[c(3, 8)] %>% 
                    dplyr::filter(Bezeichnung == input$Düngemittel) %>% 
                    select(NH4_N_PrzFM)
            })
            output$O13 <- renderTable({
                Dun[c(3, 8)] %>% 
                    dplyr::filter(Bezeichnung == input$Düngemittel) %>% 
                    select(NH4_N_PrzFM)
            })
            
            V13 <- reactive({
                Dun[c(3, 22)] %>% 
                    dplyr::filter(Bezeichnung == input$Düngemittel) %>% 
                    select(Feldemission.organisch.NH3.Faktor)
            })
            output$V13 <- renderTable({
                Dun[c(3, 22)] %>% 
                    dplyr::filter(Bezeichnung == input$Düngemittel) %>% 
                    select(Feldemission.organisch.NH3.Faktor)
            })
            
            fest <- reactive({
                Tec[c(1, 5)]  %>% 
                    dplyr::filter(Ausbringungstechnik == input$Ausbringungstechnik) %>% 
                    select(fest)
            })
            output$fest <- renderTable({
                Tec[c(1, 5)]  %>% 
                    dplyr::filter(Ausbringungstechnik == input$Ausbringungstechnik) %>% 
                    select(fest)
            })
            
            flüssig <- reactive({
                Tec[c(1, 6)]  %>% 
                    dplyr::filter(Ausbringungstechnik == input$Ausbringungstechnik) %>% 
                    select(flüssig)
            })
            output$flüssig <- renderTable({
                Tec[c(1, 6)]  %>% 
                    dplyr::filter(Ausbringungstechnik == input$Ausbringungstechnik) %>% 
                    select(flüssig)
            })
            
            L13 <- reactive({ 
                Tec[c(1, 4)] %>% 
                    dplyr::filter(Ausbringungstechnik  == input$Ausbringungstechnik) %>% 
                    select(NH3.Ausgasung)
            })
            output$L13 <- renderTable({
                Tec[c(1, 4)] %>% 
                    dplyr::filter(Ausbringungstechnik  == input$Ausbringungstechnik) %>% 
                    select(NH3.Ausgasung)
            })
            
            ES13 <- reactive({ 
                Kli[c(1, 5)] %>% 
                    dplyr::filter(Auswahl == input$Klima) %>% 
                    select(NH3.Klima.Faktor)
            })
            output$ES13 <- renderTable({
                Kli[c(1, 5)] %>% 
                    dplyr::filter(Auswahl == input$Klima) %>% 
                    select(NH3.Klima.Faktor)
            })
            
            pH_Mean <- reactive({ 
                pH[c(1, 2)] %>% 
                    dplyr::filter(pH.Wert == input$pH) %>% 
                    select(Mean)
            })
            output$pH_Mean <- renderTable({
                pH[c(1, 2)] %>% 
                    dplyr::filter(pH.Wert == input$pH) %>% 
                    select(Mean)
            })
            
            J13 <- reactive({ 
                SOC[c(1, 2)] %>% 
                    dplyr::filter(SOC == input$SOC) %>% 
                    select(Mittelwert)
            })
            output$J13 <- renderTable({
                SOC[c(1, 2)] %>% 
                    dplyr::filter(SOC == input$SOC) %>% 
                    select(Mittelwert)
            })
            
            EJ13 <- reactive({ 
                BoT[c(1, 3)] %>% 
                    dplyr::filter(Bodentextur  == input$Bodentextur) %>% 
                    select(Bodentexturfaktor)
            })
            output$EJ13 <- renderTable({
                BoT[c(1, 3)] %>% 
                    dplyr::filter(Bodentextur  == input$Bodentextur) %>% 
                    select(Bodentexturfaktor)
            })
            
            EI13 <- reactive({ 
                Dun[c(34, 38)] %>% 
                    dplyr::filter(Frucht == input$Frucht) %>% 
                    select(Fruchtart.Faktor.NH3)
            })
            output$EI13 <- renderTable({
                Dun[c(34, 38)] %>% 
                    dplyr::filter(Frucht == input$Frucht) %>% 
                    select(Fruchtart.Faktor.NH3)
            })
            
            FX13 <- reactive({ 
                Dun[c(3, 21)] %>% 
                    dplyr::filter(Bezeichnung == input$Düngemittel) %>% 
                    select(Feldemission.NH3.Faktor)
            })
            output$FX13 <- renderTable({
                Dun[c(3, 21)] %>% 
                    dplyr::filter(Bezeichnung == input$Düngemittel) %>% 
                    select(Feldemission.NH3.Faktor)
            })
            
            EP13 <- reactive({ 
                pH[c(1, 5)] %>% 
                    dplyr::filter(pH.Wert == input$pH) %>% 
                    select(Nh3.pH.Wert.Faktor)
            })
            output$EP13 <- renderTable({
                pH[c(1, 5)] %>% 
                    dplyr::filter(pH.Wert == input$pH) %>% 
                    select(Nh3.pH.Wert.Faktor)
            })
            
            Dichte <- reactive({
                Dun[c(3, 18)]  %>% 
                    dplyr::filter(Bezeichnung == input$Düngemittel) %>% 
                    select(Dichte_kg_je_l)
            })
            output$Dichte <- renderTable({
                Dun[c(3, 18)]  %>% 
                    dplyr::filter(Bezeichnung == input$Düngemittel) %>% 
                    select(Dichte_kg_je_l)
            })
            
            Einheit <- reactive({
                Einheit_test <- Dun[c(3, 5)] %>% 
                    dplyr::filter(Bezeichnung == input$Düngemittel) %>% 
                    select(Einheit) 
                
                Einheit_test[,1]
            })
            output$Einheit <- renderTable({
                Einheit_test <- Dun[c(3, 5)] %>% 
                    dplyr::filter(Bezeichnung == input$Düngemittel) %>% 
                    select(Einheit) 
                
                Einheit_test[,1]
            })
            
            N13 <- reactive({
                FEm[c(3, 4)] %>% 
                dplyr::filter(Bezeichnung == input$Düngemittel) %>% 
                select(Nges_PrzFM)
            })
            output$N13 <- renderTable({
                    FEm[c(3, 4)] %>% 
                    dplyr::filter(Bezeichnung == input$Düngemittel) %>% 
                    select(Nges_PrzFM)
            })
            
        }
)
