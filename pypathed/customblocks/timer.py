import signal

from i3pyblocks import blocks, utils


class ImprovedCounterBlock(blocks.PollingBlock):
    """Block that shows a 'Hello World!' text."""
    def __init__(self):
        super().__init__(sleep=1)
        self.timer = 0

    @property
    def timer_str(self) -> str:
        timer = self.timer
        hours = timer // 3600
        timer -= hours * 3600
        minutes = timer // 60
        timer -= minutes * 60
        seconds = timer
        return f"{hours:02}:{minutes:02}:{seconds:02}"

    async def signal_handler(self, *, sig: signal.Signals) -> None:
        if sig == signal.SIGUSR1:
            with open('/tmp/timer') as f:
                self.timer = int(f.read())

    async def run(self) -> None:
        if self.timer == 0:
            self.update('')
            return
        self.update(f"Timer: {self.timer_str}")
        self.timer -= 1
