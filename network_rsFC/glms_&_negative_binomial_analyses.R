
#load packages

library("boot")
library("pscl")
library("ggplot2")
library("foreign")
library("MASS")
library("RColorBrewer")
library("interactions")
library("lme4")
library("AER")
library("lattice")
library("knitr")


#input data
task_neg_103 <- read.csv("/Users/jflanner/Documents/RESTING/Networks/R_count_anaylses/input_data/task_neg_103.csv")

task_neg_103$cb.f <- factor(task_neg_103$cb, levels = 0:1)
is.factor(task_neg_103$cb.f)

task_neg_103 <- within(task_neg_103, {
    cb.ct <- C(cb.f, treatment)
    print(attributes(cb.ct))
})

task_neg_103$sex.f <- factor(task_neg_103$sex, levels = 0:1)
is.factor(task_neg_103$sex.f)

task_neg_103 <- within(task_neg_103, {
    sex.ct <- C(sex.f, treatment)
    print(attributes(sex.ct))
})

task_neg_103$current_nic.f <- factor(task_neg_103$current_nic, levels = 0:1)
is.factor(task_neg_103$current_nic.f)

task_neg_103 <- within(task_neg_103, {
    current_nic.ct <- C(current_nic.f, treatment)
    print(attributes(current_nic.ct))
})

#input data
task_pos_103 <- read.csv("/Users/jflanner/Documents/RESTING/Networks/R_count_anaylses/input_data/task_pos_103.csv")

task_pos_103$cb.f <- factor(task_pos_103$cb, levels = 0:1)
is.factor(task_pos_103$cb.f)

task_pos_103 <- within(task_pos_103, {
    cb.ct <- C(cb.f, treatment)
    print(attributes(cb.ct))
})

task_pos_103$sex.f <- factor(task_pos_103$sex, levels = 0:1)
is.factor(task_pos_103$sex.f)

task_pos_103 <- within(task_pos_103, {
    sex.ct <- C(sex.f, treatment)
    print(attributes(sex.ct))
})

task_pos_103$current_nic.f <- factor(task_pos_103$current_nic, levels = 0:1)
is.factor(task_pos_103$current_nic.f)

task_pos_103 <- within(task_pos_103, {
    current_nic.ct <- C(current_nic.f, treatment)
    print(attributes(current_nic.ct))
})











#input data
data_93 <- read.csv("/Users/jflanner/Documents/RESTING/Networks/R_count_anaylses/input_data/data_93.csv")

data_93$hiv.f <- factor(data_93$hiv, levels = 0:1)
is.factor(data_93$hiv.f)

data_93 <- within(data_93, {
    hiv.ct <- C(hiv.f, treatment)
    print(attributes(hiv.ct))
})

data_93$cb.f <- factor(data_93$cb, levels = 0:1)
is.factor(data_93$cb.f)

data_93 <- within(data_93, {
    cb.ct <- C(cb.f, treatment)
    print(attributes(cb.ct))
})

data_93$sex.f <- factor(data_93$sex, levels = 0:1)
is.factor(data_93$sex.f)

data_93 <- within(data_93, {
    sex.ct <- C(sex.f, treatment)
    print(attributes(sex.ct))
})

data_93$current_nic.f <- factor(data_93$current_nic, levels = 0:1)
is.factor(data_93$current_nic.f)

data_93 <- within(data_93, {
    current_nic.ct <- C(current_nic.f, treatment)
    print(attributes(current_nic.ct))
})


#input data
data_86_hiv <- read.csv("/Users/jflanner/Documents/RESTING/Networks/data_86_hiv.csv")

data_86_hiv$hiv.f <- factor(data_86_hiv$hiv, levels = 0:1)
is.factor(data_86_hiv$hiv.f)

data_86_hiv <- within(data_86_hiv, {
    hiv.ct <- C(hiv.f, treatment)
    print(attributes(hiv.ct))
})

data_86_hiv$cb.f <- factor(data_86_hiv$cb, levels = 0:1)
is.factor(data_86_hiv$cb.f)

data_86_hiv <- within(data_86_hiv, {
    cb.ct <- C(cb.f, treatment)
    print(attributes(cb.ct))
})

data_86_hiv$sex.f <- factor(data_86_hiv$sex, levels = 1:2)
is.factor(data_86_hiv$sex.f)

data_86_hiv <- within(data_86_hiv, {
    sex.ct <- C(sex.f, treatment)
    print(attributes(sex.ct))
})

data_86_hiv$current_nic.f <- factor(data_86_hiv$current_nic, levels = 0:1)
is.factor(data_86_hiv$current_nic.f)

data_86_hiv <- within(data_86_hiv, {
    current_nic.ct <- C(current_nic.f, treatment)
    print(attributes(current_nic.ct))
})






#input data (subjects with both viable task data and resting state data)
data_86 <- read.csv("/Users/jflanner/Documents/RESTING/Networks/R_count_anaylses/input_data/data_86.csv")
data_86$hiv.f <- factor(data_86$hiv, levels = 0:1)
is.factor(data_86$hiv.f)

data_86 <- within(data_86, {
    hiv.ct <- C(hiv.f, treatment)
    print(attributes(hiv.ct))
})

data_86$cb.f <- factor(data_86$cb, levels = 0:1)
is.factor(data_86$cb.f)

data_86 <- within(data_86, {
    cb.ct <- C(cb.f, treatment)
    print(attributes(cb.ct))
})

data_86$sex.f <- factor(data_86$sex, levels = 0:1)
is.factor(data_86$sex.f)

data_86 <- within(data_86, {
    sex.ct <- C(sex.f, treatment)
    print(attributes(sex.ct))
})

data_86$current_nic.f <- factor(data_86$current_nic, levels = 0:1)
is.factor(data_86$current_nic.f)

data_86 <- within(data_86, {
    current_nic.ct <- C(current_nic.f, treatment)
    print(attributes(current_nic.ct))
})
summary(data_86)

#input data
data_103 <- read.csv("/Users/jflanner/Documents/RESTING/Networks/R_count_anaylses/input_data/data_103.csv")

data_103$hiv.f <- factor(data_103$hiv, levels = 0:1)
is.factor(data_103$hiv.f)

data_103 <- within(data_103, {
    hiv.ct <- C(hiv.f, treatment)
    print(attributes(hiv.ct))
})

data_103$cb.f <- factor(data_103$cb, levels = 0:1)
is.factor(data_103$cb.f)

data_103 <- within(data_103, {
    cb.ct <- C(cb.f, treatment)
    print(attributes(cb.ct))
})

data_103$sex.f <- factor(data_103$sex, levels = 0:1)
is.factor(data_103$sex.f)

data_103 <- within(data_103, {
    sex.ct <- C(sex.f, treatment)
    print(attributes(sex.ct))
})

data_103$current_nic.f <- factor(data_103$current_nic, levels = 0:1)
is.factor(data_103$current_nic.f)

data_103 <- within(data_103, {
    current_nic.ct <- C(current_nic.f, treatment)
    print(attributes(current_nic.ct))
})





########################################################################################################
#Calculate RAI variables
#RAI: Higher values indicate either positive synchronization of SN with ENC and/or negative synchronization of SN with DMN
#RAI = f(CC SN,ENC) – f(CC SN,DMN)
#f(CC) = 0.5*ln((1+CC)/(1-CC)) 
########################################################################################################



data_86$transformed_SNDMN = 0.5*log((1 + data_86$SNDMN)/(1 - data_86$SNDMN))
data_86$transformed_SNRECN = 0.5*log((1 + data_86$SNRECN)/(1 - data_86$SNRECN))
data_86$transformed_SNLECN = 0.5*log((1 + data_86$SNLECN)/(1 - data_86$SNLECN))


data_86$R_RAI = data_86$transformed_SNRECN - data_86$transformed_SNDMN
data_86$L_RAI = data_86$transformed_SNLECN - data_86$transformed_SNDMN

head(data_86)


data_93$transformed_SNDMN = 0.5*log((1 + data_93$SNDMN)/(1 - data_93$SNDMN))
data_93$transformed_SNRECN = 0.5*log((1 + data_93$SNRECN)/(1 - data_93$SNRECN))
data_93$transformed_SNLECN = 0.5*log((1 + data_93$SNLECN)/(1 - data_93$SNLECN))

data_93$R_RAI = data_93$transformed_SNRECN - data_93$transformed_SNDMN
data_93$L_RAI = data_93$transformed_SNLECN - data_93$transformed_SNDMN

head(data_93)



########################################################################
#save new data files
write.csv(data_93, "/Users/jflanner/Documents/RESTING/Networks/R_count_anaylses/data_93_output.csv")
write.csv(data_86, "/Users/jflanner/Documents/RESTING/Networks/R_count_anaylses/data_86_output.csv")

########################################################################################################
#HIV x CB interaction effects?
########################################################################################################

summary(L_RAI_HIVCB <- glm(formula = L_RAI ~ age + sex.ct + current_nic.ct + mean_FD + hiv.ct + cb.ct + hiv.ct * cb.ct, data = data_93, family = "gaussian"))
anova(L_RAI_HIVCB, test = "F")

summary(R_RAI_HIVCB <- glm(formula = R_RAI ~ age + sex.ct + current_nic.ct + mean_FD + hiv.ct + cb.ct + hiv.ct * cb.ct, data = data_93, family = "gaussian"))
anova(R_RAI_HIVCB, test = "F")

summary(SNDMN_HIVCB <- glm(formula = SNDMN ~ age + sex.ct + current_nic.ct + mean_FD + hiv.ct + cb.ct + hiv.ct * cb.ct, data = data_93, family = "gaussian"))
anova(SNDMN_HIVCB, test = "F")

summary(SNRECN_HIVCB <- glm(formula = SNRECN ~ age + sex.ct + current_nic.ct + mean_FD + hiv.ct + cb.ct + hiv.ct * cb.ct, data = data_93, family = "gaussian"))
anova(SNRECN_HIVCB, test = "F")

summary(SNLECN_HIVCB <- glm(formula = SNLECN ~ age + sex.ct + current_nic.ct + mean_FD + hiv.ct + cb.ct + hiv.ct * cb.ct, data = data_93, family = "gaussian"))
anova(SNLECN_HIVCB, test = "F")

##################################################################################################
#save residuals of x and y for plotting 
##################################################################################################

summary(L_RAI_HIVCB_RES <- glm(formula = L_RAI ~ age + sex + current_nic + mean_FD, data = data_93, family = "gaussian"))
data_93$L_RAI_RES = residuals(L_RAI_HIVCB_RES)

summary(R_RAI_HIVCB_RES <- glm(formula = R_RAI ~ age + sex + current_nic + mean_FD, data = data_93, family = "gaussian"))
data_93$R_RAI_RES = residuals(R_RAI_HIVCB_RES)

summary(SNDMN_HIVCB_RES <- glm(formula = SNDMN ~ age + sex + current_nic + mean_FD, data = data_93, family = "gaussian"))
data_93$SNDMN_RES = residuals(SNDMN_HIVCB_RES)

summary(SNRECN_HIVCB_RES <- glm(formula = SNRECN ~ age + sex + current_nic + mean_FD, data = data_93, family = "gaussian"))
data_93$SNRECN_RES = residuals(SNRECN_HIVCB_RES)

summary(SNLECN_HIVCB_RES <- glm(formula = SNLECN ~ age + sex + current_nic + mean_FD, data = data_93, family = "gaussian"))
data_93$SNLECN_RES = residuals(SNLECN_HIVCB_RES)

write.csv(data_93,'./data_93_output.csv')


########################################################################################################
#REST connectivity related to task network actviation?
########################################################################################################

#ERROR
summary(L_RAI_DMN_err <- glm(formula = L_RAI ~ age + sex + current_nic + mean_FD + hiv + cb + DMN_err, data = data_86, family = "gaussian"))
summary(L_RAI_SN_err <- glm(formula = L_RAI ~ age + sex + current_nic + mean_FD + hiv + cb + SN_err, data = data_86, family = "gaussian"))
summary(L_RAI_RECN_err <- glm(formula = L_RAI ~ age + sex + current_nic + mean_FD + hiv + cb + RECN_err, data = data_86, family = "gaussian"))
summary(L_RAI_LECN_err <- glm(formula = L_RAI ~ age + sex + current_nic + mean_FD + hiv + cb + LECN_err, data = data_86, family = "gaussian"))

#ERROR
summary(R_RAI_DMN_err <- glm(formula = R_RAI ~ age + sex + current_nic + mean_FD + hiv + cb + DMN_err, data = data_86, family = "gaussian"))
summary(R_RAI_SN_err <- glm(formula = R_RAI ~ age + sex + current_nic + mean_FD + hiv + cb + SN_err, data = data_86, family = "gaussian"))
summary(R_RAI_RECN_err <- glm(formula = R_RAI ~ age + sex + current_nic + mean_FD + hiv + cb + RECN_err, data = data_86, family = "gaussian"))
summary(R_RAI_LECN_err <- glm(formula = R_RAI ~ age + sex + current_nic + mean_FD + hiv + cb + LECN_err, data = data_86, family = "gaussian"))

#ERROR
summary(SNDMN_DMN_err <- glm(formula = SNDMN ~ age + sex + current_nic + mean_FD + hiv + cb + DMN_err, data = data_86, family = "gaussian"))
summary(SNDMN_SN_err <- glm(formula = SNDMN ~ age + sex + current_nic + mean_FD + hiv + cb + SN_err, data = data_86, family = "gaussian"))
summary(SNDMN_RECN_err <- glm(formula = SNDMN ~ age + sex + current_nic + mean_FD + hiv + cb + RECN_err, data = data_86, family = "gaussian"))
summary(SNDMN_LECN_err <- glm(formula = SNDMN ~ age + sex + current_nic + mean_FD + hiv + cb + LECN_err, data = data_86, family = "gaussian"))

#ERROR
summary(SNRECN_DMN_err <- glm(formula = SNRECN ~ age + sex + current_nic + mean_FD + hiv + cb + DMN_err, data = data_86, family = "gaussian"))
summary(SNRECN_SN_err <- glm(formula = SNRECN ~ age + sex + current_nic + mean_FD + hiv + cb + SN_err, data = data_86, family = "gaussian"))
summary(SNRECN_RECN_err <- glm(formula = SNRECN ~ age + sex + current_nic + mean_FD + hiv + cb + RECN_err, data = data_86, family = "gaussian"))
summary(SNRECN_LECN_err <- glm(formula = SNRECN ~ age + sex + current_nic + mean_FD + hiv + cb + LECN_err, data = data_86, family = "gaussian"))

#ERROR
summary(SNLECN_DMN_err <- glm(formula = SNLECN ~ age + sex + current_nic + mean_FD + hiv + cb + DMN_err, data = data_86, family = "gaussian"))
summary(SNLECN_SN_err <- glm(formula = SNLECN ~ age + sex + current_nic + mean_FD + hiv + cb + SN_err, data = data_86, family = "gaussian"))
summary(SNLECN_RECN_err <- glm(formula = SNLECN ~ age + sex + current_nic + mean_FD + hiv + cb + RECN_err, data = data_86, family = "gaussian"))
summary(SNLECN_LECN_err <- glm(formula = SNLECN ~ age + sex + current_nic + mean_FD + hiv + cb + LECN_err, data = data_86, family = "gaussian"))

########################################################################################################################
#rest connectivity related to number of unaware errors in task?
######################################################################################################################

## histogram of unaware error count variables
ggplot(data_86, aes(n_nogo_unaware)) + geom_histogram()

## histogram with x axis in log10 scale
ggplot(data_86, aes(n_nogo_unaware)) + geom_histogram() + scale_x_log10()

###################################################################################################################################
#testing for overdipersion (mean = standard deviation)
###################################################################################################################################

#check for assumption that data is not over dispersed: conditonal variance and mean are simlar (at each level of hiv)
mean(data_86$n_nogo_unaware)
sd(data_86$n_nogo_unaware)

with(data_86, tapply(n_nogo_unaware, hiv, function(x) {
  sprintf("M (SD) = %1.2f (%1.2f)", mean(x), sd(x))
}))

###################################################################################################################################
#testing for overdipersion with formal test (first requires running possion models)
###################################################################################################################################

# Run a Poisson regression in R using the glm function in one of the core packages
#Possion regression Model without zero infation model

#Cameron and Trivedi (2009) recommended using robust standard errors for the parameter estimates to control for mild violation of the distribution assumption that the variance equals the mean. We use R package sandwich below to obtain the robust standard errors and calculated the p-values accordingly. Together with the p-values, we have also calculated the 95% confidence interval using the parameter estimates and their robust standard errors.

summary(R_RAI_poss <- glm(formula = n_nogo_unaware ~ cb + age + sex + current_nic + mean_FD + hiv + R_RAI, family = poisson, data = data_86))
cov.R_RAI_poss <- vcovHC(R_RAI_poss, type="HC0")
std.err <- sqrt(diag(cov.R_RAI_poss))
r.est <- cbind(Estimate= coef(R_RAI_poss), "Robust SE" = std.err,
"Pr(>|z|)" = 2 * pnorm(abs(coef(R_RAI_poss)/std.err), lower.tail=FALSE),
LL = coef(R_RAI_poss) - 1.96 * std.err,
UL = coef(R_RAI_poss) + 1.96 * std.err)
r.est


summary(L_RAI_poss <- glm(formula = n_nogo_unaware ~ cb + age + sex + current_nic + mean_FD + hiv + L_RAI, family = poisson, data = data_86))
cov.L_RAI_poss <- vcovHC(L_RAI_poss, type="HC0")
std.err <- sqrt(diag(cov.L_RAI_poss))
r.est <- cbind(Estimate= coef(L_RAI_poss), "Robust SE" = std.err,
"Pr(>|z|)" = 2 * pnorm(abs(coef(L_RAI_poss)/std.err), lower.tail=FALSE),
LL = coef(L_RAI_poss) - 1.96 * std.err,
UL = coef(L_RAI_poss) + 1.96 * std.err)
r.est


summary(SNDMN_poss <- glm(formula = n_nogo_unaware ~ cb + age + sex + current_nic + mean_FD + hiv + SNDMN, family = poisson, data = data_86))
cov.SNDMN_poss <- vcovHC(SNDMN_poss, type="HC0")
std.err <- sqrt(diag(cov.SNDMN_poss))
r.est <- cbind(Estimate= coef(SNDMN_poss), "Robust SE" = std.err,
"Pr(>|z|)" = 2 * pnorm(abs(coef(SNDMN_poss)/std.err), lower.tail=FALSE),
LL = coef(SNDMN_poss) - 1.96 * std.err,
UL = coef(SNDMN_poss) + 1.96 * std.err)
r.est

summary(SNRECN_poss <- glm(formula = n_nogo_unaware ~ cb + age + sex + current_nic + mean_FD + hiv + SNRECN, family = poisson, data = data_86))
cov.SNRECN_poss <- vcovHC(SNRECN_poss, type="HC0")
std.err <- sqrt(diag(cov.SNRECN_poss))
r.est <- cbind(Estimate= coef(SNRECN_poss), "Robust SE" = std.err,
"Pr(>|z|)" = 2 * pnorm(abs(coef(SNRECN_poss)/std.err), lower.tail=FALSE),
LL = coef(SNRECN_poss) - 1.96 * std.err,
UL = coef(SNRECN_poss) + 1.96 * std.err)
r.est

summary(SNLECN_poss <- glm(formula = n_nogo_unaware ~ cb + age + sex + current_nic + mean_FD + hiv + SNLECN, family = poisson, data = data_86))
cov.SNLECN_poss <- vcovHC(SNLECN_poss, type="HC0")
std.err <- sqrt(diag(cov.SNLECN_poss))
r.est <- cbind(Estimate= coef(SNLECN_poss), "Robust SE" = std.err,
"Pr(>|z|)" = 2 * pnorm(abs(coef(SNLECN_poss)/std.err), lower.tail=FALSE),
LL = coef(SNLECN_poss) - 1.96 * std.err,
UL = coef(SNLECN_poss) + 1.96 * std.err)
r.est

dispersiontest(L_RAI_poss)
dispersiontest(R_RAI_poss)
dispersiontest(SNDMN_poss)
dispersiontest(SNRECN_poss)
dispersiontest(SNLECN_poss)

########################################################################################################
########################################################################################################
#negative Binomial Model (when sd is larger than mean data is overdipersed and standard errors in poisson model can be inaccurate leading to inaccurate lower p-values) 


summary(R_RAI_nb <- glm.nb(n_nogo_unaware ~ cb.ct + age + sex.ct + current_nic.ct + mean_FD + hiv.ct + R_RAI, data = data_86))
summary(L_RAI_nb <- glm.nb(n_nogo_unaware ~ cb.ct + age + sex.ct + current_nic.ct + mean_FD + hiv.ct + L_RAI, data = data_86))
summary(SNDMN_nb <- glm.nb(n_nogo_unaware ~ cb.ct + age + sex.ct + current_nic.ct + mean_FD + hiv.ct + SNDMN, data = data_86))
summary(SNLECN_nb <- glm.nb(n_nogo_unaware ~ cb.ct + age + sex.ct + current_nic.ct + mean_FD + hiv.ct + SNLECN, data = data_86))
summary(SNRECN_nb <- glm.nb(n_nogo_unaware ~ cb.ct + age + sex.ct + current_nic.ct + mean_FD + hiv.ct + SNRECN, data = data_86))


#############################################################################################################################


summary(LECN_err_nb <- glm.nb(n_nogo_unaware ~ cb.ct + age + sex.ct + current_nic.ct + hiv.ct + LECN_err, data = data_103))
summary(RECN_err_nb <- glm.nb(n_nogo_unaware ~ cb.ct + age + sex.ct + current_nic.ct + hiv.ct + RECN_err, data = data_103))

summary(DMN_err_nb <- glm.nb(n_nogo_unaware ~ cb.ct + age + sex.ct + current_nic.ct + hiv.ct + DMN_err, data = data_103))
summary(SN_err_nb <- glm.nb(n_nogo_unaware ~ cb.ct + age + sex.ct + current_nic.ct + hiv.ct + SN_err, data = data_103))

#make plots of models

########################################################################################################

interact_plot(R_RAI_nb, pred = R_RAI, modx = hiv.ct, x.label = "R. RAI", y.label = "UNAWARE ERRORS", geom = "line", plot.points = TRUE, interval = FALSE, legend.main = "HIV-STATUS", vary.lty = FALSE, colors = c("#2e781b", "#7e007c"), line.thickness = 0.5, point.size = 1, partial.residuals = FALSE)

interact_plot(L_RAI_nb, pred = L_RAI, modx = hiv.ct, x.label = "L. RAI", y.label = "UNAWARE ERRORS", geom = "line", plot.points = TRUE, interval = FALSE, legend.main = "HIV-STATUS", vary.lty = FALSE, colors = c("#2e781b", "#7e007c"), line.thickness = 0.5, point.size = 1, partial.residuals = FALSE)

interact_plot(SNDMN_nb, pred = SNDMN, modx = hiv.ct, x.label = "SN-DMN | covar", y.label = "UNAWARE ERRORS | covar", geom = "line", plot.points = TRUE, interval = TRUE, legend.main = "HIV-STATUS", vary.lty = FALSE, colors = c("#2e781b", "#7e007c"), line.thickness = 0.5, point.size = 1, partial.residuals = FALSE)

interact_plot(SNRECN_nb, pred = SNRECN, modx = hiv.ct, x.label = "SN-R.CEN | covar", y.label = "UNAWARE ERRORS | covar", geom = "line", plot.points = TRUE, interval = FALSE, legend.main = "HIV-STATUS", vary.lty = FALSE, colors = c("#2e781b", "#7e007c"), line.thickness = 0.5, point.size = 1, partial.residuals = FALSE)

interact_plot(SNLECN_nb, pred = SNLECN, modx = hiv.ct, x.label = "SN-L.ECN | covar", y.label = "UNAWARE ERRORS | covar", geom = "line", plot.points = TRUE, interval = FALSE, legend.main = "HIV-STATUS", vary.lty = FALSE, colors = c("#2e781b", "#7e007c"), line.thickness = 0.5, point.size = 1, partial.residuals = FALSE)

########################################################################################################








interact_plot(DMN_err_nb, pred = DMN_err, modx = hiv.ct, x.label = "DMN ERROR | covar", y.label = "UNAWARE ERRORS", geom = "line", plot.points = TRUE, interval = TRUE, legend.main = "HIV-STATUS", vary.lty = FALSE, colors = c("#2e781b", "#7e007c"), line.thickness = 0.5, point.size = 1, partial.residuals = FALSE)

interact_plot(RECN_err_nb, pred = RECN_err, modx = hiv.ct, x.label = "R. ECN ERROR", y.label = "UNAWARE ERRORS", geom = "line", plot.points = TRUE, interval = FALSE, legend.main = "HIV-STATUS", vary.lty = FALSE, colors = c("#2e781b", "#7e007c"), line.thickness = 0.5, point.size = 1, partial.residuals = FALSE)

interact_plot(LECN_err_nb, pred = LECN_err, modx = hiv.ct, x.label = "L. ECN ERROR", y.label = "UNAWARE ERRORS", geom = "line", plot.points = TRUE, interval = FALSE, legend.main = "HIV-STATUS", vary.lty = FALSE, colors = c("#2e781b", "#7e007c"), line.thickness = 0.5, point.size = 1, partial.residuals = FALSE)

interact_plot(SN_err_nb, pred = SN_err, modx = hiv.ct, x.label = "SN ERROR", y.label = "UNAWARE ERRORS", geom = "line", plot.points = TRUE, interval = FALSE, legend.main = "HIV-STATUS", vary.lty = FALSE, colors = c("#2e781b", "#7e007c"), line.thickness = 0.5, point.size = 1, partial.residuals = FALSE)
















########################################################################################################

#follow up within group
task_neg <- read.csv("/Users/jflanner/Documents/RESTING/Networks/R_count_anaylses/input_data/task_neg.csv")
task_pos <- read.csv("/Users/jflanner/Documents/RESTING/Networks/R_count_anaylses/input_data/task_pos.csv")

summary(R_RAI_nb_neg <- glm.nb(n_nogo_unaware ~ cb + age + sex + current_nic + mean_FD + R_RAI, data = task_neg))
summary(R_RAI_nb_pos <- glm.nb(n_nogo_unaware ~ cb + age + sex + current_nic + mean_FD + R_RAI, data = task_pos))

summary(L_RAI_nb_neg <- glm.nb(n_nogo_unaware ~ cb + age + sex + current_nic + mean_FD + L_RAI, data = task_neg))
summary(L_RAI_nb_pos <- glm.nb(n_nogo_unaware ~ cb + age + sex + current_nic + mean_FD + L_RAI, data = task_pos))

summary(SNDMN_nb_neg <- glm.nb(n_nogo_unaware ~ cb + age + sex + current_nic + mean_FD + SNDMN, data = task_neg))
summary(SNDMN_nb_pos <- glm.nb(n_nogo_unaware ~ cb + age + sex + current_nic + mean_FD + SNDMN, data = task_pos))

summary(SNRECN_nb_neg <- glm.nb(n_nogo_unaware ~ cb + age + sex + current_nic + mean_FD + SNRECN, data = task_neg))
summary(SNRECN_nb_pos <- glm.nb(n_nogo_unaware ~ cb + age + sex + current_nic + mean_FD + SNRECN, data = task_pos))

summary(SNLECN_nb_neg <- glm.nb(n_nogo_unaware ~ cb + age + sex + current_nic + mean_FD + SNLECN, data = task_neg))
summary(SNLECN_nb_pos <- glm.nb(n_nogo_unaware ~ cb + age + sex + current_nic + mean_FD + SNLECN, data = task_pos))

########################################################################################################
########################################################################################################
# negative binomial models with brain activity durring task
########################################################################################################

########################################################################################################
#Task defined ROIs
########################################################################################################

summary(PCC_err_nb <- glm.nb(n_nogo_unaware ~ cb + age + sex + hiv + current_nic + PCC_err, data = data_86))
summary(mPFC_err_nb <- glm.nb(n_nogo_unaware ~ cb + age + sex + hiv + current_nic + mPFC_err, data = data_86))
summary(PCC_cor_nb <- glm.nb(n_nogo_unaware ~ cb + age + sex + hiv + current_nic + PCC_cor, data = data_86))
summary(mPFC_cor_nb <- glm.nb(n_nogo_unaware ~ cb + age + sex + hiv + current_nic + mPFC_cor, data = data_86))

########################################################################################################
#network masks with behavior
########################################################################################################

summary(DMN_err_nb <- glm.nb(n_nogo_unaware ~ cb.ct + age + sex.ct + hiv.ct + current_nic.ct + hiv.ct*DMN_err + DMN_err, data = data_86))

summary(SN_err_nb <- glm.nb(n_nogo_unaware ~ cb.ct + age + sex.ct + hiv.ct + current_nic.ct + hiv.ct*SN_err + SN_err, data = data_86))

summary(LECN_err_nb <- glm.nb(n_nogo_unaware ~ cb.ct + age + sex.ct + hiv.ct + current_nic.ct + hiv.ct*LECN_err + LECN_err, data = data_86))

summary(RECN_err_nb <- glm.nb(n_nogo_unaware ~ cb.ct + age + sex.ct + hiv.ct + current_nic.ct + hiv.ct*RECN_err + RECN_err, data = data_86))



summary(DMN_cor_nb <- glm.nb(n_nogo_unaware ~ cb.ct + age + sex.ct + hiv.ct + current_nic.ct + hiv.ct*DMN_cor + DMN_cor, data = data_86))
summary(SN_cor_nb <- glm.nb(n_nogo_unaware ~ cb.ct + age + sex.ct + hiv.ct + current_nic.ct + SN_cor, data = data_86))
summary(LECN_cor_nb <- glm.nb(n_nogo_unaware ~ cb.ct + age + sex.ct + hiv.ct + current_nic.ct + LECN_cor, data = data_86))
summary(RECN_cor_nb <- glm.nb(n_nogo_unaware ~ cb.ct + age + sex.ct + hiv.ct + current_nic.ct + RECN_cor, data = data_86))

####################################################################
#plot examples
###################################################################
plot_model(DMN_err_nb, type="pred", terms = "DMN_err[all]", auto.label = FALSE, axis.title = c("DMN ERROR | covar", "UNAWARE ERRORS"), colors = c("#2e781b", "#7e007c"), title = "", line.size = 0.5, dot.size = 1, show.data = TRUE)

plot_model(SNDMN_nb, type="pred", terms = "SNDMN[all]", auto.label = FALSE, axis.title = c("SN-DMN rsFC | covar", "UNAWARE ERRORS | covar"), title = "", line.size = 0.5, dot.size = 2, show.data = TRUE)
