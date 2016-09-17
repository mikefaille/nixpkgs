{ stdenv,  buildGoPackage, fetchFromGitHub, kvm, libvirt,  docker-machine }:

buildGoPackage rec {
  rev = "5f4c9b13e14c95d90e576ba6388d47dd5b14be63";
  name = "docker-machine-kvm-${rev}";
  goPackagePath = "github.com/dhiltgen/docker-machine-kvm";

  src = fetchFromGitHub {
    inherit rev;
    owner = "dhiltgen";
    repo =  "docker-machine-kvm";
    sha256 = "0vk0pyxvx9mlv6l88ylwq1x7iyx382y9y621g93pdnmp4h6d7y9w";
   };

  buildInputs = [ libvirt ];

  subPackages = [  "./bin" ];

  goDeps = ./deps.nix;

  # postFixup =  ''
  #   mv $bin/bin/bin $bin/bin/docker-machine-driver-kvm
  # '';

  meta = with stdenv.lib; {
    description = "Run Kubernetes locally";
    license = licenses.asl20;
    homepage = https://kubernetes.io/docs/getting-started-guides/minikube/;
    maintainers = with maintainers; [offline];
    platforms = [ "x86_64-linux" ];
  };
}
