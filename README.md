# Surface mesh processing

The script computes the surface normals at faces and nodes, and computes the mean and Gaussian curvature via the local quadaratic surface parameterization. Run matlab Live Editor file SCRIPT.mlx. To use the sample brain surface data, unzip @gifti.zip file and set the path. The final outcome of the code should be the mean curvature computation:

![alt text](https://github.com/laplcebeltrami/curvatures/blob/main/190824-0001.png?raw=true)


The brief explenation is gven in [1]. The mathematical detail is given in [2].

[1] Chung, M.K., Worsley, K.J., Robbins, S., Evans, A.C. 2003. Tensor-based brain surface modeling and analysis, CVPR, 467-473
http://pages.stat.wisc.edu/~mchung/papers/CVPR/CVPR.pdf

[2] Chung. M.K. 2001, Statistical Morphometry in Computional Neuroanatomy, PhD Thesis, McGill University, Canada
http://www.stat.wisc.edu/~mchung/papers/thesis.pdf


(C) 2023 Moo K. Chung, University of Wisconsin-Madison
