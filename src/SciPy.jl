"""
A Julia interface module for SciPy

- [GitHub repository: AtsushiSakai/SciPy.jl: Julia interface for SciPy](https://github.com/AtsushiSakai/SciPy.jl)
- [Stable Doc](https://atsushisakai.github.io/SciPy.jl/stable)
- [Dev Doc](https://atsushisakai.github.io/SciPy.jl/dev)

"""
module SciPy

using PyCall
using InteractiveUtils

export print_configulations
export cluster, constants, fft, integrate, interpolate, io


const scipy = PyNULL()

"""
Scipy.cluster module

- [Clustering package (scipy.cluster) v1.4.1 Reference Guide](https://docs.scipy.org/doc/scipy/reference/cluster.html)

# Examples

You can do k-means clustering using this module:

```julia-repl
julia> features  = [[ 1.9  2.3];
                    [ 1.5 2.5];
                    [ 0.8 0.6];
                    [ 0.4 1.8];
                    [ 0.1 0.1];
                    [ 0.2 1.8];
                    [ 2.0 0.5];
                    [ 0.3 1.5];
                    [ 1.0 1.0]]
9×2 Array{Float64,2}:
 1.9  2.3
 1.5  2.5
 0.8  0.6
 0.4  1.8
 0.1  0.1
 0.2  1.8
 2.0  0.5
 0.3  1.5
 1.0  1.0

julia> whitened = SciPy.cluster.vq.whiten(features)
9×2 Array{Float64,2}:
 2.7396    2.91001
 2.16284   3.16306
 1.15351   0.759134
 0.576757  2.2774
 0.144189  0.126522
 0.288379  2.2774
 2.88379   0.632612
 0.432568  1.89784
 1.44189   1.26522

julia> SciPy.cluster.vq.kmeans(whitened, [whitened[1,:] whitened[3,:]] )
([1.1174670798453024 1.8345740800894272; 2.8837860125040065 0.6326117517549749], 1.073399
3090584457)

```

"""
const cluster = PyNULL()

"""
Scipy.constants module

- [Constants (scipy.constants) Reference Guide](https://docs.scipy.org/doc/scipy/reference/constants.html)

# Examples

You can access each constants:

```julia-repl
julia> SciPy.constants.golden
1.618033988749895

julia> SciPy.constants.physical_constants["electron mass"] 
(9.10938356e-31, "kg", 1.1e-38)

julia> SciPy.constants.convert_temperature([-40, 40.0], "Celsius", "Kelvin") 

2-element Array{Float64,1}:
 233.14999999999998
 313.15

```
"""
const constants = PyNULL()

"""
Scipy.fft module

- [Discrete Fourier transforms (scipy.fft) Reference Guide](https://docs.scipy.org/doc/scipy/reference/fft.html)


# Examples

You can use FFT (Fast Fourier Transform):

```julia-repl

julia> SciPy.fft.fft(exp.(π/8 * collect(1:8)))
8-element Array{Complex{Float64},1}:
   68.17385416403044 - 0.0im
   1.408601300061675 + 31.248171041435185im
 -10.268363617931092 + 15.207165888808841im
 -12.695027025520982 + 6.493878653648949im
 -13.216494113330363 - 0.0im
 -12.695027025520982 - 6.493878653648949im
 -10.268363617931092 - 15.207165888808841im
   1.408601300061675 - 31.248171041435185im

```
"""
const fft = PyNULL()


"""
Scipy.integrate module

- [Integration and ODEs (scipy.integrate) Reference Guide](https://docs.scipy.org/doc/scipy/reference/integrate.html)


# Examples

You can compute a definite integral:

```julia-repl
julia> f(x) = x^2
f (generic function with 1 method)

julia> SciPy.integrate.quad(f, 0, 4)
(21.333333333333336, 2.368475785867001e-13)

```
"""
const integrate = PyNULL()

"""
Scipy.interpolate module

- [Interpolation (scipy.interpolate) Reference Guide](https://docs.scipy.org/doc/scipy/reference/interpolate.html)


# Examples

You can interpolate 1D data:

```julia-repl
julia> x = collect(0:10);
julia> y = exp.(-x/3.0);
julia> f = SciPy.interpolate.interp1d(x, y);
julia> f(0.5)
0-dimensional Array{Float64,0}:
0.8582656552868946

```
"""
const interpolate = PyNULL()

"""
Scipy.io module

- [Input and output (scipy.io) Reference Guide](https://docs.scipy.org/doc/scipy/reference/io.html)


# Examples

You can save a MATLAB-style .mat file:

```julia-repl
julia> mdic = Dict([("a", 100), ("label", "experiment")])
Dict{String,Any} with 2 entries:
  "label" => "experiment"
  "a"     => 100

julia> SciPy.io.savemat("sample_data.mat", mdic)
```
"""

const io = PyNULL()


"""
Module initialization function
"""
function __init__()

    copy!(scipy, pyimport_conda("scipy", "scipy"))
    copy!(cluster, pyimport_conda("scipy.cluster", "scipy"))
    copy!(constants, pyimport_conda("scipy.constants", "scipy"))
    copy!(fft, pyimport_conda("scipy.fft", "scipy"))
    copy!(integrate, pyimport_conda("scipy.integrate", "scipy"))
    copy!(interpolate, pyimport_conda("scipy.interpolate", "scipy"))
    copy!(io, pyimport_conda("scipy.io", "scipy"))

end

"""
Print configulations:
- Julia version
- Python version
- Python path
- scipy version
"""
function print_configulations()
    println("==== SciPy.jl configulations ====")
    println("-- Julia settings --")
    versioninfo()
    println("-- PyCall.jl settings --")
    @show PyCall.pyversion
    @show PyCall.libpython
    @show PyCall.pyprogramname
    @show PyCall.conda
    println("-- Scipy settings --")
    @show scipy.__version__
    @show scipy.version.full_version
    @show scipy.version.git_revision
end


end
