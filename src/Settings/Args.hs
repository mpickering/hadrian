module Settings.Args (
    args
    ) where

import Settings.User
import Settings.GhcM
import Settings.GccM
import Settings.GhcPkg
import Settings.GhcCabal
import Expression

args :: Args
args = defaultArgs <> userArgs

-- TODO: add all other settings
-- TODO: add src-hc-args = -H32m -O
-- TODO: GhcStage2HcOpts=-O2 unless GhcUnregisterised
-- TODO: libraries/ghc-prim_dist-install_MODULES := $$(filter-out GHC.Prim, ...
-- TODO: compiler/stage1/build/Parser_HC_OPTS += -O0 -fno-ignore-interface-pragmas
-- TODO: compiler/main/GhcMake_HC_OPTS        += -auto-all
-- TODO: compiler_stage2_HADDOCK_OPTS += --optghc=-DSTAGE=2
-- TODO: compiler/prelude/PrimOp_HC_OPTS  += -fforce-recomp
-- TODO: is GhcHcOpts=-Rghc-timing needed?
defaultArgs :: Args
defaultArgs = mconcat
    [ cabalArgs
    , ghcPkgArgs
    , ghcMArgs
    , gccMArgs
    , customPackageArgs ]