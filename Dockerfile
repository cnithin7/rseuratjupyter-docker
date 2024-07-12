FROM bioconductor/bioconductor_docker:devel

# Update apt-get and install TensorFlow
RUN apt-get update \
    && pip install tensorflow \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install various Bioconductor packages
RUN R -e "BiocManager::install(c('multtest', 'S4Vectors', 'SummarizedExperiment', 'SingleCellExperiment', 'MAST', 'DESeq2', 'BiocGenerics', 'GenomicRanges', 'IRanges', 'rtracklayer', 'monocle', 'Biobase', 'limma', 'glmGamPoi', 'SingleR','scRepertoire','cowplot','celldex','rhdf5','singleCellTK','ComplexHeatmap', 'biomaRt'))"



# Install Jupyter and IRkernel
RUN pip install jupyter \
    && R -e "install.packages('IRkernel', repos='http://cran.us.r-project.org')" \
    && R -e "IRkernel::installspec(user = FALSE)"

# Install additional R packages from GitHub
RUN R -e 'remotes::install_github("chris-mcginnis-ucsf/DoubletFinder")'
RUN R -e 'devtools::install_github("cole-trapnell-lab/monocle3")'
RUN R -e 'devtools::install_github("digitalcytometry/cytotrace2", subdir = "cytotrace2_r")'
RUN R -e 'devtools::install_github("diazlab/CONICS/CONICSmat", dep = FALSE)'
RUN R -e 'devtools::install_github("arc85/singleseqgset")'

RUN R -e 'remotes::install_github("satijalab/seurat-data", "seurat5", quiet = TRUE)'
RUN R -e 'remotes::install_github("satijalab/azimuth", "seurat5", quiet = TRUE)'
RUN R -e 'remotes::install_github("satijalab/seurat-wrappers", "seurat5", quiet = TRUE)'
RUN R -e 'remotes::install_github("stuart-lab/signac", "seurat5", quiet = TRUE)'

# Install additional CRAN packages
RUN R -e 'install.packages("tidyverse", repos="http://cran.us.r-project.org")'
RUN R -e 'install.packages("ggrepel", repos="http://cran.us.r-project.org")'
RUN R -e 'install.packages("ggplotify", repos="http://cran.us.r-project.org")'
RUN R -e 'install.packages("gtools", repos="http://cran.us.r-project.org")'
RUN R -e 'install.packages("beanplot")'
RUN R -e 'install.packages("mixtools")'
RUN R -e 'install.packages("pheatmap")'
RUN R -e 'install.packages("zoo", repos="http://cran.us.r-project.org")'
RUN R -e 'install.packages("squash", repos="http://cran.us.r-project.org")'

WORKDIR /workspace

EXPOSE 8888

CMD ["sh", "-c", "jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root"]
