library(tidyverse)
library(data.table)

# Set working directory
#wd <- "C:\\Users\\angel.naya-geiger\\Desktop\\2021js_Optaklim_Mila\\"
#setwd(wd)

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

#SoN <- read.csv2("MiLA_SoilN.csv")
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



Fruchtfolgeglied <- 1
Menge <- 500
Fru <- Kul$Fruchtart[1]
Düngemittel <- FEm$Bezeichnung[1]
Anzahl anzurechnender Fruchtfolgeglieder <- 1
Ausbri <- Tec$Ausbringungstechnik[1]
Temp <-  20
Klima <- Kli$Auswahl[1]
Auswaschungsgefahr <- "ja"
Schlagnummer <-  1
Bodentex <- BoT$Bodentextur[1]
SoilN <- SoN$Auswahl[1]
SOC_Wert <- SOC$SOC[1]
pH_Wert <- pH$pH.Wert[1]

    



    I13 <- Menge
    
    M13 <- Temp
    
    
    
    N13 <- 
      FEm[c(3, 4)] %>% 
      filter(Bezeichnung == Düngemittel) %>% 
        select(Nges_PrzFM)
    
    Einheit <- 
      Dun[c(3, 5)] %>% 
      filter(Bezeichnung == Düngemittel) %>% 
      select(Einheit) 
    
    Dichte <- 
      Dun[c(3, 18)]  %>% 
      filter(Bezeichnung == Düngemittel) %>%  
      select(Dichte_kg_je_l)
    
    EP13 <- 
      pH[c(1, 5)] %>% 
      filter(pH.Wert == pH_Wert) %>%  
      select(Nh3.pH.Wert.Faktor)
    
    FX13 <-  
      Dun[c(3, 21)] %>% 
      filter(Bezeichnung == Düngemittel) %>%  
      select(Feldemission.NH3.Faktor)
    
    EI13 <- 
      Dun[c(34, 38)] %>% 
      filter(Frucht == Fru) %>%  
      select(Fruchtart.Faktor.NH3)
    
    EJ13 <- 
      BoT[c(1, 3)] %>% 
      filter(Bodentextur == Bodentex) %>%
      select(Bodentexturfaktor)
    
    J13 <- 
      SOC[c(1, 2)] %>%  
      filter(SOC == SOC_Wert) %>% 
      select(Mittelwert)
    
    pH_Mean <-  
      pH[c(1, 2)] %>% 
      filter(pH.Wert == pH_Wert) %>%  
      select(Mean)
    
    ES13 <- 
      Kli[c(1, 5)] %>% 
      filter(Auswahl == Klima) %>%
      select(NH3.Klima.Faktor)
    
    L13 <- 
      Tec[c(1, 4)] %>% 
      filter(Ausbringungstechnik == Ausbri) %>%
      select(NH3.Ausgasung)
    
    flüssig <- 
      Tec[c(1, 6)]  %>% 
      filter(Ausbringungstechnik == Ausbri) %>%
      select(flüssig)
    
    fest <- 
      Tec[c(1, 5)]  %>% 
      filter(Ausbringungstechnik == Ausbri) %>%
      select(fest)
    
    V13 <- 
      Dun[c(3, 22)] %>% 
      filter(Bezeichnung == Düngemittel) %>% 
      select(Feldemission.organisch.NH3.Faktor)
    
    O13 <- 
      Dun[c(3, 8)] %>% 
      filter(Bezeichnung == Düngemittel) %>% 
      select(NH4_N_PrzFM)
    
    HV13 <- 
      Dun[c(3, 22)] %>% 
      filter(Bezeichnung == Düngemittel) %>% 
      select(Feldemission.organisch.NH3.Faktor)
    
    FN13 <- 
      Dun[c(3, 20)] %>% 
      filter(Bezeichnung == Düngemittel) %>% 
      select(Feldemission.NO.Faktor)
    
    P13 <- 
      Dun[c(3, 9)] %>% 
      filter(Bezeichnung == Düngemittel) %>% 
      select(Harnstoff_N_PrzFM)
    
    EN13 <- 
      SoN[c(1, 3, 5)] %>% 
      filter(Auswahl == SoilN) %>% 
      select(NO.SOC.Faktor)
    
    EM13 <- 
      Kli[c(1, 4)] %>% 
      filter(Auswahl == Klima) %>% 
      select(NO.Klima.Faktor)
    
    AF13 <- 
      Dun[c(2, 3)] %>% 
      filter(Bezeichnung == Düngemittel) %>% 
      select(ID_DüngerArt )
    
    EK13 <- 
      SOC[c(1, 4)] %>% 
      filter(SOC == SOC_Wert) %>% 
      select(N2O.SOC.Faktor)
    
    EO13 <- 
      pH[c(1, 3)] %>% 
      filter(pH.Wert == pH_Wert) %>% 
      select(N2O.pH.Wert.Faktor)
    
    ER13 <- 
      Kli[c(1, 4)] %>% 
      filter(Auswahl == Klima) %>% 
      select(NO.Klima.Faktor)
    
    Q13 <- 
      Dun[c(3, 16)] %>%  
      filter(Bezeichnung == Düngemittel) %>% 
      select(CaCO3_PRZFM) 
    
    FD13 <- 
      Dun[c(3, 19)] %>% 
      filter(Bezeichnung == Düngemittel) %>% 
      select(Feldemission.N2O.Faktor)
    
    EH13 <- 
      Dun[c(34, 36)] %>% 
      filter(Frucht == Fru) %>% 
      select(Fruchtart.Faktor.N2O)
    
    Schluff <- 
      BoT[c(1, 6)] %>% 
      filter(Bodentextur  == Bodentex) %>% 
      select(Schluffgehalt)
    
    Ton <- 
      BoT[c(1, 5)] %>% 
      filter(Bodentextur  == Bodentex) %>% 
      select(Tongehalt)
    
    R13 <- 
      if (pH_Mean == 5.0) {
        0.4
      } else if (pH_Mean == 6.4){
        0.6
      } else if (pH_Mean == 7.9){
        0.8
      } else if (pH_Mean == 9){
        1
      }
    
    S13 <- 
      ((Ton * 0.5) + (Schluff * 0.05))
    
    T13 <- 
      J13 * 1.72 * 2
    
    U13 <-  
      T13 * R13 + S13
    
    FD1 <- Fak %>% select(FD1)
    
    FE1 <- Fak %>% select(FE1)
    
    F_AE13 <-  
      Dun[c(3, 31)] %>% 
      filter(Bezeichnung == Düngemittel) %>%
      select(Summe.KEA_Dünger..MJ.kg.Dünger.)
    
    F_Q13 <- 
      Dun[c(3, 17)] %>%  
      filter(Bezeichnung == Düngemittel) %>%
        select(THG_Faktor)
    
    
    ###
    
    
    EQ13 <- 
      if (U13 <= 16 ) {
        KAK$NH3.KAK.FAKTOR[1]
      } else if (U13 > 16 & U13 <= 24){
        KAK$NH3.KAK.FAKTOR[2]
      } else if (U13 > 24 & U13 <= 32){
        KAK$NH3.KAK.FAKTOR[3]
      } else if (U13 > 32){
        KAK$NH3.KAK.FAKTOR[4]
      } 
    
    GH13 <- 
      if (Einheit == DX2) {
        Dichte * I13 * N13 / 100
      } else if (Einheit == DX1){
        I13() * 1000  * N13 / 100
      } else {
        I13 * N13 / 100
      }
    
    HB13 <- 
      GH13[,1] * exp(EI13[,1] + FX13[,1] + EP13[,1] + EQ13 + ES13[,1] + L13[,1])
    
    IP13.2 <- 
      if (V13 == 0.4) {
        fest
      } else {    
        flüssig
      }
    
    IP13.1 <- 
      if (Einheit == DX2) {
        Dichte * I13
      } else if (Einheit == DX1){
        I13 * 1000
      } else {
        I13    
      }
    
    IF13 <- 
      if (HV13[,1] == 0.4 & M13 < 10) {
        0.3
      } else if (HV13[,1] == 0.4 & M13 >= 10 & M13 < 15) {
        0.4
      } else if (HV13[,1] == 0.4 & M13 >= 15 & M13 < 25) {
        0.5
      } else if (HV13[,1] == 0.4 & M13 >= 25 & M13 < 40) {
        0.9
      } else if (HV13[,1] == 0.2 & M13 < 10) {
        0.1
      } else if (HV13[,1] == 0.2 & M13 >= 10 & M13 < 15) {
        0.2
      } else if (HV13[,1] == 0.2 & M13 >= 15 & M13 < 25) {
        0.25
      } else if (HV13[,1] == 0.2 & M13 >= 25 & M13 < 40) {
        0.7
      } else {
        0.9
      }
    
    
    IP13 <- 
      IP13.1 * O13 / 100 * IF13 * IP13.2 *(14/17)
    
    GR13 <- if (GH13 != 0) {
        exp ( FE1[,1] + (GH13 * FN13) + EN13 + EM13)
      }       else {
        0
      } 
    
    IZ13 <- 
      if (AF13 == 2) {HB13} else {IP13}
    
    KN13 <- 
      (((Menge * P13 / 100) * 100 / 46.6423576) * 0.2) * (44 / 12)
    
    KD13 <-    
      ((Menge * Q13 / 100) * 0.12) * (44 / 12)
    
    HL13 <- 
      if (GH13[,1] != 0) {
        exp(FD1[,1] + ((GH13[,1] - GR13 - IZ13) * FD13[,1]) + EH13[,1] + EJ13[,1] + EK13[,1] + EO13[,1] + ER13[,1])
      } else {
        0
      }
    
    JJ13 <-  
      if (Auswaschungsgefahr == "ja" ) {
        (GH13[,1] - (GH13[,1] * 0.07) - HL13 - GR13 - HB13) * 0.3 * 0.0075
      } else  {0} 
  
    Feldemissionen_CO2 <- 
      (((((IZ13 + GR13) * 0.01) + HL13 + JJ13) * (44 / 28)) * 298) + KD13 + KN13
    
    Düngerherstellung_CO2 <- 
      if (Einheit == DX2) {
        F_Q13 * Dichte * I13
      } else if (Einheit == DX1){
        F_Q13 * I13 * 1000
      } else {
        F_Q13 * I13    
      }
    
    Düngerherstellung_KEA <- 
      if (Einheit == DX2) {
        F_AE13 * Dichte * I13
      } else if (Einheit == DX1){
        F_AE13 * I13 * 1000
      } else {
        F_AE13 * I13    
      }
    
    Feldemissionen <- 
      FEm[c(3:9)] %>% 
      filter(Bezeichnung == Düngemittel) %>% 
        rename(N = Nges_PrzFM,
               NH4N = NH4_N_PrzFM,
               Harnstoff = Harnstoff_N_PrzFM,
               P2O5 = P2O5_PrzFM,
               K2O = K2O_PrzFM,
               CaCO3 = CaCO3_PRZFM
        )
    
    Ergebnisse <- 
      data.table(Düngerherstellung_CO2 = Düngerherstellung_CO2[,1],
                 Düngerherstellung_KEA = Düngerherstellung_KEA[,1],
                 Feldemissionen_CO2 = Feldemissionen_CO2[,1])
    
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    