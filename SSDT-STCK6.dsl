// configuration data for other SSDTs in this pack (STCK6)

DefinitionBlock("", "SSDT", 2, "hack", "RM-STCK6", 0)
{
    Device(RMCF)
    {
        Name(_ADR, 0)   // do not remove

        // AUDL: Audio Layout
        //
        // The value here will be used to inject layout-id for HDEF and HDAU
        // If set to Ones, no audio injection will be done.
        Name(AUDL, 1)

        // FAKH: Fake HDMI Aduio
        //
        // 0: Disable spoofing of HDEF for FakePCIID_Intel_HDMI_Audio.kext
        // 1: Allow spoofing of HDEF for FakePCIID_Intel_HDMI_Audio.kext
        Name(FAKH, 1)
    }

    // In DSDT, native _PTS is renamed ZPTS
    // As a result, calls to these methods land here.
    External(ZPTS, MethodObj)
    External(_SB.PCI0.XHC.PMEE, FieldUnitObj)
    Method(_PTS, 1)
    {
        ZPTS(Arg0)
        If (5 == Arg0)
        {
            // avoid "auto restart" after shutdown
            \_SB.PCI0.XHC.PMEE = 0
        }
    }

    #include "SSDT-PluginType1.dsl"
    #include "SSDT-XOSI.dsl"
    #include "SSDT-IGPU.dsl"
    #include "SSDT-USB-STCK.dsl"
    #include "SSDT-XHC.dsl"
    #include "SSDT-HDEF.dsl"
    #include "SSDT-EC.dsl"
    #include "SSDT-RMNE.dsl"
}
//EOF