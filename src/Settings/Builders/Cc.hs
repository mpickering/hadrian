module Settings.Builders.Cc (ccBuilderArgs) where

import Base
import Oracles.Config.Setting
import Oracles.PackageData
import Predicate
import Settings.Builders.Common
import Settings

-- TODO: handle custom $1_$2_MKDEPENDC_OPTS and
ccBuilderArgs :: Args
ccBuilderArgs = mconcat
    [ builder (Cc Compile) ?
        mconcat [ commonCcArgs
                , arg "-c", arg =<< getInput
                , arg "-o", arg =<< getOutput ]

    , builder (Cc FindDependencies) ? do
        output <- getOutput
        mconcat [ arg "-E"
                , arg "-MM"
                , commonCcArgs
                , arg "-MF"
                , arg output
                , arg "-MT"
                , arg $ dropExtension output -<.> "o"
                , arg "-x"
                , arg "c"
                , arg =<< getInput ] ]

commonCcArgs :: Args
commonCcArgs = mconcat [ append =<< getPkgDataList CcArgs
                       , append =<< getSettingList . ConfCcArgs =<< getStage
                       , cIncludeArgs ]
