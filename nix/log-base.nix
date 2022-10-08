{ mkDerivation, aeson, aeson-pretty, base, bytestring, deepseq
, exceptions, fetchgit, lib, mmorph, monad-control, mtl, semigroups
, stm, text, time, transformers-base, unliftio-core
, unordered-containers
}:
mkDerivation {
  pname = "log-base";
  version = "0.11.1.0";
  src = fetchgit {
    url = "https://github.com/scrive/log";
    sha256 = "1rj687przkxh3nmlk0qlgp6yn7jclpwrc6p8lny0pald0z3i19cg";
    rev = "73b47357bc9ef6bb579eaf74ddae25630f03f08f";
    fetchSubmodules = true;
  };
  postUnpack = "sourceRoot+=/./log-base; echo source root reset to $sourceRoot";
  libraryHaskellDepends = [
    aeson aeson-pretty base bytestring deepseq exceptions mmorph
    monad-control mtl semigroups stm text time transformers-base
    unliftio-core unordered-containers
  ];
  homepage = "https://github.com/scrive/log";
  description = "Structured logging solution (base package)";
  license = lib.licenses.bsd3;
}
