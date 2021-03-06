library(ggplot2)
library(dplyr)
library(WVPlots)
library(gridExtra)
library(grid)


# simular datos para cofactores y tratamientos

# tamaño muestra

size <- 50

# factores

genero <- rep(c("female","male"),each=3*size)
diente <- rep(c("canino izquierdo",
                "canino derecho",
                "lateral izquierdo"),
              each=size,times=2)

data_plot <- data.frame(null=rep(0,times=3*size),
                        genero = rep(c("female","male"),each=3*size),
                        diente = rep(c("canino izquierdo",
                                       "canino derecho",
                                       "lateral izquierdo"),
                                     each=size,times=2),
                        mediciones = c(rnorm(size, mean=9.63, sd=0.7637),
                                       rnorm(size, mean=9.67, sd=0.8283),
                                       rnorm(size, mean=8.43, sd=0.7474),
                                       rnorm(size, mean=10.31, sd=0.8935),
                                       rnorm(size, mean=10.43, sd=0.9665),
                                       rnorm(size, mean=8.70, sd=0.7719)
                                       )
                        )


# Variabilidad de las mediciones dentales: diente|mujeres

new_data <- data_plot %>% filter(genero=="female")

ggplot(new_data, aes(x=mediciones, y=null)) + 
  geom_point(size=3, shape=16, color = "blue", alpha = 0.4) +
  scale_x_continuous(limits = c(6, 12)) +
  facet_grid(diente ~ .)

data_plot %>% 
  filter(genero=="female") %>% 
  group_by(diente) %>%
  summarise(mediaMuestral = mean(mediciones),
            desviaciónEst. = sd(mediciones),
            CV=sd(mediciones)/mean(mediciones))

# solo canino izquierdo

new_data <- data_plot %>% filter(diente=="canino derecho")

ggplot(new_data, aes(x=mediciones, y=null)) + 
  geom_point(size=3, shape=16, color = "blue", alpha = 0.4) +
  scale_x_continuous(limits = c(6, 12)) +
  facet_grid(genero ~ .)


# Variabilidad de las mediciones dentales: genero*diente

ggplot(data_plot, aes(x=mediciones, y=null)) + 
  geom_point(size=3, shape=16, color = "blue", alpha = 0.4) +
  scale_x_continuous(limits = c(6, 12)) +
  facet_grid(diente + genero ~ .)

data_plot %>% 
  group_by(genero,diente) %>%
  summarise(mediaMuestral = mean(mediciones),
            desviaciónEst. = sd(mediciones),
            CV=sd(mediciones)/mean(mediciones))


# Variabilidad de las mediciones dentales: diente|mujeres
# caso extremo Normal para ejemplo

size <- 100
data_plot <- data.frame(null=rep(0,times=3*size),
                        genero = rep(c("female","male"),each=3*size),
                        diente = rep(c("canino izquierdo",
                                       "canino derecho",
                                       "lateral izquierdo"),
                                     each=size,times=2),
                        mediciones = c(rnorm(size, mean=9.63, sd=0.7637),
                                       rnorm(size, mean=9.67, sd=1.5283),
                                       rnorm(size, mean=8.43, sd=2.7474),
                                       rnorm(size, mean=10.31, sd=0.8935),
                                       rnorm(size, mean=10.43, sd=0.9665),
                                       rnorm(size, mean=8.70, sd=0.7719)
                        )
)

data_plot %>% 
  filter(genero=="female") %>% 
  group_by(diente) %>%
  summarise(mediaMuestral = mean(mediciones),
            desviaciónEst. = sd(mediciones),
            CV=sd(mediciones)/mean(mediciones))

new_data <- data_plot %>% filter(genero=="female")

ggplot(new_data, aes(x=mediciones, y=null)) + 
  geom_point(size=3, shape=16, color = "blue", alpha = 0.5) +
  scale_x_continuous(limits = c(4, 14)) +
  facet_grid(diente ~ .)

# Variabilidad de las mediciones dentales: diente|mujeres
# caso extremo Weibull para ejemplo

size <- 100
data_plot <- data.frame(null=rep(0,times=3*size),
                        genero = rep(c("female","male"),each=3*size),
                        diente = rep(c("canino izquierdo",
                                       "canino derecho",
                                       "lateral izquierdo"),
                                     each=size,times=2),
                        mediciones = c(rweibull(size, 0.5, scale = 9.63),
                                       rweibull(size, 3, scale = 9.67),
                                       rweibull(size, 8, scale = 8.43),
                                       rnorm(size, mean=10.31, sd=0.8935),
                                       rnorm(size, mean=10.43, sd=0.9665),
                                       rnorm(size, mean=8.70, sd=0.7719)
                        )
)

data_plot %>% 
  filter(genero=="female") %>% 
  group_by(diente) %>%
  summarise(mediaMuestral = mean(mediciones),
            desviaciónEst. = sd(mediciones),
            CV=sd(mediciones)/mean(mediciones))

new_data <- data_plot %>% filter(genero=="female")

ggplot(new_data, aes(x=mediciones, y=null)) + 
  geom_point(size=3, shape=16, color = "blue", alpha = 0.5) +
  scale_x_continuous(limits = c(4, 14)) +
  facet_grid(diente ~ .)

# Variabilidad de las mediciones dentales: diente|mujeres
# caso extremo Normal multimodal para ejemplo

size <- 100
data_plot <- data.frame(null=rep(0,times=3*size),
                        genero = rep(c("female","male"),each=3*size),
                        diente = rep(c("canino izquierdo",
                                       "canino derecho",
                                       "lateral izquierdo"),
                                     each=size,times=2),
                        mediciones = c(c(rnorm(size/2, mean=11, sd=0.4637),
                                         rnorm(size/2, mean=6, sd=0.4637)),
                                       c(rnorm(size/2, mean=6, sd=1.7637),
                                         rnorm(size/2, mean=11, sd=1.7637)),
                                       rnorm(size, mean=8.43, sd=0.7474),
                                       rnorm(size, mean=10.31, sd=0.8935),
                                       rnorm(size, mean=10.43, sd=0.9665),
                                       rnorm(size, mean=8.70, sd=0.7719)
                        )
)

data_plot %>% 
  filter(genero=="female") %>% 
  group_by(diente) %>%
  summarise(mediaMuestral = mean(mediciones),
            desviaciónEst. = sd(mediciones),
            CV=sd(mediciones)/mean(mediciones))

new_data <- data_plot %>% filter(genero=="female")

ggplot(new_data, aes(x=mediciones, y=null)) + 
  geom_point(size=3, shape=16, color = "blue", alpha = 0.5) +
  scale_x_continuous(limits = c(4, 14)) +
  facet_grid(diente ~ .)


# simulacion bibnomial para survival analysis

size <- 15*12

data_plot <- data.frame(null=rep(0,times=2*size),
                        restauracion = rep(c("cast","resin"),each=2*size),
                        coronal_dentin = rep(c("absent",
                                       "present"),
                                     each=size,times=2),
                        mediciones = c(rbinom(size,372,prob=0.027),
                                       rbinom(size,372,prob=0.027),
                                       rbinom(15*12,372,prob=0.00285),
                                       rbinom(15*12,372,prob=0.00285)
                                       )
                        )

data_plot %>% 
  summarise(mediaMuestral = mean(mediciones),
            desviaciónEst. = sd(mediciones),
            CV=sd(mediciones)/mean(mediciones))

p1=
ggplot(data_plot, aes(x=mediciones, y=null)) + 
  geom_point(size=3, shape=16, color = "blue", alpha = 0.3) +
  scale_x_continuous(limits = c(0, 30)) +
  facet_grid(restauracion ~ .)

# todos los datos
p2=
ggplot(data_plot, aes(x=mediciones, y=null)) + 
  geom_point(size=3, shape=16, color = "blue", alpha = 0.3) +
  scale_x_continuous(limits = c(0, 30))

grid.arrange(p2, p1, ncol=1)

# efecto de la dentina remanente
# los valores por tipo de restauracion

size <- 15*12

data_plot <- data.frame(null=rep(0,times=2*size),
                        restauracion = rep(c("cast","resin"),each=2*size),
                        coronal_dentin = rep(c("absent",
                                               "present"),
                                             each=size,times=2),
                        mediciones = c(rbinom(size,372,prob=0.027),
                                       rbinom(size,372,prob=0.097),
                                       rbinom(15*12,372,prob=0.00285),
                                       rbinom(15*12,372,prob=0.0885)
                        )
)

new_data <- data_plot %>% filter(restauracion=="cast")

p=1
ggplot(new_data, aes(x=mediciones, y=null)) + 
  geom_point(size=3, shape=16, color = "blue", alpha = 0.5) +
  scale_x_continuous(limits = c(0, 30))
p=2
ggplot(new_data, aes(x=mediciones, y=null)) + 
  geom_point(aes(color=coronal_dentin), size=3, shape=16,alpha = 0.5) +
  scale_x_continuous(limits = c(0, 30))
grid.arrange(p2, p1, ncol=1)


# confounding

size <- 15*12

data_plot <- data.frame(null=rep(0,times=2*size),
                        restauracion = rep(c("cast","resin"),each=2*size),
                        coronal_dentin = rep(c("absent",
                                               "present"),
                                             each=size,times=2),
                        mediciones = c(rbinom(size,372,prob=0.007),
                                       rbinom(size,372,prob=0.097),
                                       rbinom(size,372,prob=0.097),
                                       rbinom(size,372,prob=0.007)
                        )
)


ggplot(data_plot, aes(x=mediciones, y=null)) + 
  geom_point(size=3, shape=16, color = "blue", alpha = 0.5) +
  facet_grid(restauracion ~ .)

ggplot(data_plot, aes(x=mediciones, y=null)) + 
  geom_point(size=3, shape=16, color = "blue", alpha = 0.5) +
  geom_point(aes(color=coronal_dentin), size=3, shape=16,alpha = 0.5) +
  facet_grid(restauracion ~ .)

# control por coronal_dentin

new_data <- data_plot %>% filter(coronal_dentin=="absent")

ggplot(new_data, aes(x=mediciones, y=null)) + 
  geom_point(size=3, shape=16, color = "blue", alpha = 0.5) +
  scale_x_continuous(limits = c(0, 30))+
  facet_grid(restauracion ~ .)


ggplot(new_data, aes(x=mediciones, y=null)) + 
  geom_point(aes(color=restauracion), size=3, shape=16,alpha = 0.5) +
  scale_x_continuous(limits = c(0, 30))



