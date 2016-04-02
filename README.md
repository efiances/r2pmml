R2PMML
======

R package for converting R models to PMML

# Features #

This package complements the standard [`pmml` package] (http://cran.r-project.org/web/packages/pmml/):

* It supports several model types (eg. `gbm`, `train`) that are not supported by the standard `pmml` package.
* It is extremely fast and memory efficient. For example, it can convert a typical `randomForest` model to a PMML file in a few seconds time, whereas the standard `pmml` package requires several hours to do the same.

# Prerequisites #

* R platform:
  * [`rJava` package] (http://cran.r-project.org/web/packages/rJava/)
* Java 1.7 or newer. The Java executable must be available on system path.

# Installation #

This package is not available in the [CRAN package repository] (http://cran.r-project.org/) yet.

Installing the package from its GitHub repository using the [`devtools` package] (http://cran.r-project.org/web/packages/devtools/):
```R
library("devtools")

install_github(repo = "jpmml/r2pmml")
```

# Usage #

Loading the package:
```R
library("r2pmml")
```

When converting large files, then it may become necessary to increase JVM heap space by declaring the `java.parameters` option. Please note that this option must be declared **before** the `r2pmml` package (or any other package that depends on the `rJava` package) is loaded:
```R
options("java.parameters" = c("-Xms4G", "-Xmx8G"))

library("r2pmml")
```

The conversion is handled by the newly defined `r2pmml(x, file)` function:
```R
library("randomForest")

data(iris)

rf = randomForest(Species ~ ., data = iris, ntree = 7)
print(rf)

r2pmml(rf, "/tmp/rf.pmml")
```

# De-installation #

Removing the package:
```R
remove.packages("r2pmml")
```

# License #

R2PMML is licensed under the [GNU Affero General Public License (AGPL) version 3.0] (http://www.gnu.org/licenses/agpl-3.0.html). Other licenses are available on request.

# Additional information #

Please contact [info@openscoring.io] (mailto:info@openscoring.io)
