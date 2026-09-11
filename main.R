install.packages("climate")
library(climate)

dzis <- Sys.Date()

legionowo <- sounding_wyoming(
  wmo_id = 12374,
  yy = as.numeric(format(dzis, "%Y")),
  mm = as.numeric(format(dzis, "%m")),
  dd = as.numeric(format(dzis, "%d")),
  hh = 12
)

profil   <- legionowo[[1]]

warunek_powstania_chmury <- which(profil$TEMP == profil$DWPT)

if (length(warunek_powstania_chmury) > 0) {
  podstawa_chmury <- profil$HGHT[warunek_powstania_chmury[1]]
} else {
  podstawa_chmury <- NA
}

podstawa_chmury
