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

for (i in 1:nrow(profil)) {
  wysokosc <- profil$HGHT[i]
  if (is.na(wysokosc)) next
  delta_H <- wysokosc - H0
  T_parcel <- T0 - (0.0098 * delta_H)
  Td_parcel <- Td0 - (0.0018 * delta_H)
  if (!is.na(T_parcel) && !is.na(Td_parcel) && T_parcel <= Td_parcel) {
    LCL_hght <- wysokosc
    break
  }
}

LCL_hght
