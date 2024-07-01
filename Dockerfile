FROM bioconductor/bioconductor_docker:devel

RUN apt-get update \
    && pip install tensorflow \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN R -e "BiocManager::install(c('multtest', 'S4Vectors', 'SummarizedExperiment', 'SingleCellExperiment', 'MAST', 'DESeq2', 'BiocGenerics', 'GenomicRanges', 'IRanges', 'rtracklayer', 'monocle', 'Biobase', 'limma', 'glmGamPoi', 'SingleR','scRepertoire','cowplot','celldex','rhdf5','singleCellTK'))"

RUN pip install jupyter \
    && R -e "install.packages('IRkernel', repos='http://cran.us.r-project.org')" \
    && R -e "IRkernel::installspec(user = FALSE)"

RUN R -e 'remotes::install_github("satijalab/seurat", ref="seurat5", quiet=TRUE); remotes::install_github("satijalab/seurat-wrappers")'


RUN R -e 'devtools::install_github("cole-trapnell-lab/monocle3")'

RUN R -e 'install.packages("tidyverse", repos="http://cran.us.r-project.org")'

WORKDIR /workspace

EXPOSE 8888

CMD ["sh", "-c", "jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root"]



