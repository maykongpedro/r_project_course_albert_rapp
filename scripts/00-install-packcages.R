
# pacotes necessários
libs <- c(
  'tidyverse',
  'ggtext',
  'thematic',
  'palmerpenguins',
  'camcorder',
  'ragg',
  'here',
  'gapminder',
  'janitor',
  'gghighlight',
  'hexbin',
  'patchwork',
  'geomtextpath'
)


# checar se todos os pacotes necessários já estão instalados
installed_libs <- libs %in% rownames(
  installed.packages()
)

# instalar pacotes que não estão instalados
if(any(installed_libs == FALSE)){
  install.packages(
    libs[!installed_libs]
  )
}

# carregar pacotes (etapa opcional)
# invisible(lapply(
#   libs, library,
#   character.only = TRUE
# ))
```
