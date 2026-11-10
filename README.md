# Longitudinal Clinical Data Wrangling & Survival Cohort Merging

Pipeline de transformation de données longitudinales de santé sous **R (Tidyverse)** : pivotage d'un registre de suivi répété (format long vers large) et jointure relationnelle avec une cohorte d'analyse de survie.

---

## Contexte & Problématique Métier

Dans les études épidémiologiques et les essais cliniques, les données des patients se présentent couramment sous deux formats complémentaires :
1. Une table **baseline** (une ligne par patient) documentant les caractéristiques initiales et le critère de jugement en analyse de survie (temps d'événement, censure).
2. Un registre **longitudinal** (format long, plusieurs lignes par patient) répertoriant les consultations successives et les biomarqueurs dosés à des temps de visite répétés.

L'objectif de ce projet est de restructurer les observations cliniques séquentielles en format large (*wide format*) par patient et d'opérer une jointure relationnelle sans perte d'information pour alimenter des modèles prédictifs multivariés ou des analyses à mesures répétées.

---

## Données d'étude (Mayo Clinic PBC Study)

Le projet exploite les données de l'essai clinique de la Mayo Clinic sur la **Cirrhose Biliaire Primitive (PBC)** issues du package `survival` :
* **`pbc`** : Données transversales et suivi de survie de 418 patients (âge, sexe, statut, durée de survie, traitement).
* **`pbcseq`** : 1 945 mesures longitudinales répétées documentant l'évolution des marqueurs biologiques et cliniques au fil des jours (`day`), notamment :
  * Bilirubine sérique (`bili`)
  * Albumine (`albumin`)
  * Phosphatases alcalines (`alk.phos`)
  * Transaminases (`ast`)
  * Numération plaquettaire (`platelet`)
  * Stade histologique de la maladie (`stage`)

---

## Stack Technique & Fonctions Clés

* **Langage** : R
* **Librairies** : `survival`, `dplyr`, `tidyr`
* **Opérations clés** :
  * `tidyr::pivot_wider()` : Décomposition matricielle des variables biologiques indexées par jour de consultation (`names_from = day`, `names_prefix = "day_"`).
  * `dplyr::left_join()` : Jointure relationnelle gauche indexée sur l'identifiant patient unique (`by = "id"`).
  * Contrôle d'intégrité : détection d'unicité et de non-duplication (`duplicated()`).

---

## 🚀 Exécution du script

### Prérequis
```r
install.packages(c("survival", "dplyr", "tidyr"))
