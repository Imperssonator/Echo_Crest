function out = NoisyBranin(x,err)

out = Branin(x) + randn()*err;

end