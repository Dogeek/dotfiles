from i3pyblocks import core, utils
from i3pyblocks.blocks import datetime, i3ipc, ps, pulse, x11


async def main():
    runner = core.Runner()

    await runner.register_block(
        datetime.DateTimeBlock(
            format_date="%Y-%m-%d",
            format_time="%H:%M:%S",
        )
    )
    await runner.register_block(
        i3ipc.WindowTitleBlock()
    )
    await runner.register_block(
        ps.CpuPercentBlock()
    )
    await runner.register_block(
        ps.DiskUsageBlock()
    )
    await runner.register_block(
        ps.NetworkSpeedBlock()
    )
    await runner.register_block(
        ps.SensorsTemperatureBlock()
    )
    await runner.register_block(
        pulse.PulseAudioBlock()
    )
    await runner.register_block(
        x11.DPMSBlock(
            format_on='-',
            format_off='x',
        )
    )

    await runner.start()


utils.asyncio_run(main())
