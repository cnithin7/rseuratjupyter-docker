FROM bioconductor/bioconductor_docker:devel

# Update apt-get and install necessary packages
RUN apt-get update \
    && apt-get install -y python3-pip wget gdebi-core \
    && pip3 install tensorflow \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install RStudio Server
RUN wget https://download2.rstudio.org/rstudio-server-debian9_1.4.1717_amd64.deb \
    && gdebi -n rstudio-server-debian9_1.4.1717_amd64.deb \
    && rm rstudio-server-debian9_1.4.1717_amd64.deb

# Install various Bioconductor packages
RUN R -e "BiocManager::install(c('multtest', 'S4Vectors', 'SummarizedExperiment', 'SingleCellExperiment', 'MAST', 'DESeq2', 'BiocGenerics', 'GenomicRanges', 'IRanges', 'rtracklayer', 'monocle', 'Biobase', 'limma', 'glmGamPoi', 'SingleR', 'scRepertoire', 'cowplot', 'celldex', 'rhdf5', 'singleCellTK', 'ComplexHeatmap'))"

# Install Jupyter and IRkernel
RUN pip3 install jupyter \
    && R -e "install.packages('IRkernel', repos='http://cran.us.r-project.org')" \
    && R -e "IRkernel::installspec(user = FALSE)"

# Install additional R packages from GitHub
RUN R -e 'remotes::install_github("chris-mcginnis-ucsf/DoubletFinder")' \
    && R -e 'devtools::install_github("cole-trapnell-lab/monocle3")' \
    && R -e 'devtools::install_github("digitalcytometry/cytotrace2", subdir = "cytotrace2_r")' \
    && R -e 'devtools::install_github("arc85/singleseqgset")' \
    && R -e  'remotes::install_github("satijalab/seurat", "seurat5", quiet = TRUE)'

# Install additional CRAN packages
RUN R -e 'install.packages(c("tidyverse", "ggrepel", "ggplotify", "gtools", "beanplot", "mixtools", "pheatmap", "zoo", "squash","scCustomize","harmony"), repos="http://cran.us.r-project.org")'

# Install additional Bioconductor package
RUN R -e "BiocManager::install('biomaRt')"

# Install CONICSmat from GitHub
RUN R -e 'devtools::install_github("diazlab/CONICS/CONICSmat", dep = FALSE)'

# Set working directory
WORKDIR /workspace

# Expose ports for Jupyter and RStudio Server
EXPOSE 8888 8787

# Start Jupyter Notebook and RStudio Server
CMD ["sh", "-c", "jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root & rstudio-server start && tail -f /var/log/rstudio-server/rstudio-server.log"]
