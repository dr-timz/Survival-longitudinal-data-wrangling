# On commence tout d’abord par installer les packages nécessaires 
# (à exécuter dans la console uniquement une première fois)
# install.packages("survival")
# install.packages("tidyr")
# install.packages("dplyr")

# Ensuite, on charge les packages :
library(survival)
library(tidyr)
library(dplyr)

# Charger les données
data(pbc, package = "survival")

# Transformer pbcseq du format long au format large transformer cette table en format large pour avoir une seule ligne par patient, avec plusieurs colonnes représentant les mesures à différents jours.
pbcseq_wide <- pbcseq %>%
  pivot_wider(
    id_cols = id,                      # chaque patient aura désormais une seule ligne dans le tableau, même s’il avait plusieurs mesures dans le temps.
    names_from = day,                  # les différents jours (day = 0, 100, 200…) deviennent des noms de colonnes pour distinguer les mesures prises à différents moments.
    values_from = c(albumin, `alk.phos`, ascites, ast, bili, chol,
                    edema, hepato, platelet, protime,
                    spiders, stage)    # toutes les mesures que j'ai listé (albumin, alk.phos, etc.) vont chacune devenir plusieurs colonnes, une pour chaque moment de suivi (day).
  )

# Joindre avec la table pbc
pbc_final <- left_join(pbc, pbcseq_wide, by = "id")

# Vérification
dim(pbc_final)   # dimensions
head(pbc_final)  # aperçu
duplicated(pbc_final)
