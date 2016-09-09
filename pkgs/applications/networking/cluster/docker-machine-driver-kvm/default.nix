{ stdenv, buildGoPackage, fetchFromGitHub, go, git, libvirt }:


buildGoPackage rec {


  rev = "5f4c9b13e14c95d90e576ba6388d47dd5b14be63";
  name = "docker-machine-kvm-${rev}";


  src = fetchFromGitHub {
    inherit rev;
    owner = "dhiltgen";
    repo =  "docker-machine-kvm";
    sha256 = "0vk0pyxvx9mlv6l88ylwq1x7iyx382y9y621g93pdnmp4h6d7y9w";
    };



  # buildInputs = [ go git ];
  goPackagePath = "github.com/dhiltgen/docker-machine-kvm";
  subPackages = [ "bin"  ];



  buildPhase =  ''
  runHook preBuild

  (cd "go/src/$goPackagePath/bin" && make)
  # if [ -n "$subPackages" ] ; then

  #       for p in $subPackages ; do
  #           go install $makeFlags -p $NIX_BUILD_CORES -v $goPackagePath/$p
  #       done
  #   else
  #       find . -type d | while read d; do
  #           for i in $d/*.go; do
  #               go install $makeFlags -p $NIX_BUILD_CORES -v $d
  #               break
  #           done
  #       done
  #   fi
    runHook postBuild
  '';

  # configurePhase = ''
  # # export
  # runHook preConfigure

  # # cd \"\$NIX_BUILD_TOP\"

  # mkdir -p go/src/$(dirname "$goPackagePath")

  # ln -s "$sourceRoot" "go/src/$goPackagePath"
  # ls $NIX_BUILD_TOP/go
  # export GOPATH=$NIX_BUILD_TOP/go:$GOPATH
  # (cd "go/src/$goPackagePath" && make)

   # '';

  # buildPhase = ''
  #   # cd $GOPATH
  #   # mkdir -p src/github.com/dhiltgen
  #   # ln -s $(pwd) src/github.com/dhiltgen/docker-machine-kvm
  #   # export GOPATH=$(pwd)
  #   ls $GOPATH
  #   (cd $GOPATH/src/github.com/dhiltgen/docker-machine-kvm/bin && go get .)

  # '';





  # meta = with stdenv.lib; {
  #   description = "Run Kubernetes locally";
  #   license = licenses.asl20;
  #   homepage = https://kubernetes.io/docs/getting-started-guides/minikube/;
  #   maintainers = with maintainers; [offline];
  #   platforms = [ "x86_64-linux" ];
  # };
}
