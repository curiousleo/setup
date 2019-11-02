{ config, systemd, ... }:

let
  lorri = import (fetchTarball "https://github.com/target/lorri/tarball/rolling-release") {};
  socketUnit = "lorri";
  socketPath = "lorri/daemon.socket";
in
  {
    config = {
      systemd.user.sockets.${socketUnit} = {
        description = "Socket for Lorri Daemon";
        enable = true;
        wantedBy = [ "sockets.target" ];
        socketConfig = {
          ListenStream = "%t/${socketPath}";
          RuntimeDirectory = "lorri";
        };
      };

      systemd.user.services.lorri = {
        description = "Lorri Daemon";
        requires = [ "${socketUnit}.socket" ];
        after = [ "${socketUnit}.socket" ];
        unitConfig = {
          ConditionUser = "!@system";
          RefuseManualStart = true;
        };
        serviceConfig = {
          ExecStart = "${lorri}/bin/lorri daemon";
          PrivateTmp = true;
          ProtectSystem = "strict";
          ProtectHome = "read-only";
          Restart = "on-failure";
        };
      };
    };
  }
