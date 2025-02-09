# 90% CI means 5% 50% and 95% quantiles

# Stylophora pistillata

sigma.quantile_Spis <- quantile(sigma_DN_Spis, probs=c(0.05,0.5,0.95))
distance_Spis <- seq(0, 1500, 10)

p.d.l_Spis <- (1/(sigma.quantile_Spis[2]*sqrt(2)))*exp(-sqrt(2)*distance_Spis/sigma.quantile_Spis[2])
p.d.l.n_Spis <- (p.d.l_Spis - min(p.d.l_Spis))/(max(p.d.l_Spis)-min(p.d.l_Spis))

p.d.l.l_Spis <- (1/(sigma.quantile_Spis[1]*sqrt(2)))*exp(-sqrt(2)*distance_Spis/sigma.quantile_Spis[1])
p.d.l.l.n_Spis <- (p.d.l.l_Spis - min(p.d.l.l_Spis))/(max(p.d.l.l_Spis)-min(p.d.l.l_Spis))

p.d.l.u_Spis <- (1/(sigma.quantile_Spis[3]*sqrt(2)))*exp(-sqrt(2)*distance_Spis/sigma.quantile_Spis[3])
p.d.l.u.n_Spis <- (p.d.l.u_Spis - min(p.d.l.u_Spis))/(max(p.d.l.u_Spis)-min(p.d.l.u_Spis))
  
res_Spis <- data.frame(cond1 = "regression",
                  x = distance_Spis,
                  y = p.d.l.n_Spis,
                  ymin = p.d.l.l.n_Spis,
                  ymax = p.d.l.u.n_Spis)

rib_Spis <- geom_ribbon(data = res_Spis, aes(x = x, y = y, ymin = ymin, ymax = ymax,
                                   fill = cond1), fill = 'lightgray', alpha = 0.8)

kernel.laplace_Spis <- as.data.frame(cbind(distance_Spis, p.d.l.n_Spis, p.d.l.l.n_Spis, p.d.l.u.n_Spis))

Spis_kernel <- ggplot(kernel.laplace_Spis, aes(distance_Spis, p.d.l.n_Spis)) +
  rib_Spis +
  geom_line(color = "gray40") + 
  ylab("Normilised dispersal strenght") +
  xlab("Dispersal distance (m)") +
  theme_bw()

# Pocillopora verrucosa

sigma.quantile_Pver <- quantile(sigma_DN_Pver, probs=c(0.05,0.5,0.95))
distance_Pver <- seq(0, 100000, 10)

p.d.l_Pver <- (1/(sigma.quantile_Pver[2]*sqrt(2)))*exp(-sqrt(2)*distance_Pver/sigma.quantile_Pver[2])
p.d.l.n_Pver <- (p.d.l_Pver - min(p.d.l_Pver))/(max(p.d.l_Pver)-min(p.d.l_Pver))

p.d.l.l_Pver <- (1/(sigma.quantile_Pver[1]*sqrt(2)))*exp(-sqrt(2)*distance_Pver/sigma.quantile_Pver[1])
p.d.l.l.n_Pver <- (p.d.l.l_Pver - min(p.d.l.l_Pver))/(max(p.d.l.l_Pver)-min(p.d.l.l_Pver))

p.d.l.u_Pver <- (1/(sigma.quantile_Pver[3]*sqrt(2)))*exp(-sqrt(2)*distance_Pver/sigma.quantile_Pver[3])
p.d.l.u.n_Pver <- (p.d.l.u_Pver - min(p.d.l.u_Pver))/(max(p.d.l.u_Pver)-min(p.d.l.u_Pver))

res_Pver <- data.frame(cond1 = "regression",
                  x = distance_Pver,
                  y = p.d.l.n_Pver,
                  ymin = p.d.l.l.n_Pver,
                  ymax = p.d.l.u.n_Pver)

rib_Pver <- geom_ribbon(data = res_Pver, aes(x = x, y = y, ymin = ymin, ymax = ymax,
                                   fill = cond1), fill = 'lightgray', alpha = 0.8)

kernel.laplace_Pver <- as.data.frame(cbind(distance_Pver, p.d.l.n_Pver, p.d.l.l.n_Pver, p.d.l.u.n_Pver))

Pver_kernel <- ggplot(kernel.laplace_Pver, aes(distance_Pver, p.d.l.n_Pver)) +
  rib_Pver +
  geom_line(color = "gray40") + 
  ylab("Normilised dispersal strenght") +
  xlab("Dispersal distance (m)") +
  theme_bw()
