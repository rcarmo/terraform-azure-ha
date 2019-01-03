<WadCfg>
  <DiagnosticMonitorConfiguration overallQuotaInMB="4096">
    <DiagnosticInfrastructureLogs scheduledTransferPeriod="PT1M" scheduledTransferLogLevelFilter="Warning"/>
    <PerformanceCounters scheduledTransferPeriod="PT1M">
      <PerformanceCounterConfiguration counterSpecifier="\Memory\AvailableMemory" sampleRate="PT15S" unit="Bytes">
        <annotation displayName="Memory available" locale="en-us"/>
      </PerformanceCounterConfiguration>
      <PerformanceCounterConfiguration counterSpecifier="\Memory\PercentAvailableMemory" sampleRate="PT15S" unit="Percent">
        <annotation displayName="Mem. percent available" locale="en-us"/>
      </PerformanceCounterConfiguration>
      <PerformanceCounterConfiguration counterSpecifier="\Memory\UsedMemory" sampleRate="PT15S" unit="Bytes">
        <annotation displayName="Memory used" locale="en-us"/>
      </PerformanceCounterConfiguration>
      <PerformanceCounterConfiguration counterSpecifier="\Memory\PercentUsedMemory" sampleRate="PT15S" unit="Percent">
        <annotation displayName="Memory percentage" locale="en-us"/>
      </PerformanceCounterConfiguration>
      <PerformanceCounterConfiguration counterSpecifier="\Memory\PercentUsedByCache" sampleRate="PT15S" unit="Percent">
        <annotation displayName="Mem. used by cache" locale="en-us"/>
      </PerformanceCounterConfiguration>
      <PerformanceCounterConfiguration counterSpecifier="\Memory\PagesPerSec" sampleRate="PT15S" unit="CountPerSecond">
        <annotation displayName="Pages" locale="en-us"/>
      </PerformanceCounterConfiguration>
      <PerformanceCounterConfiguration counterSpecifier="\Memory\PagesReadPerSec" sampleRate="PT15S" unit="CountPerSecond">
        <annotation displayName="Page reads" locale="en-us"/>
      </PerformanceCounterConfiguration>
      <PerformanceCounterConfiguration counterSpecifier="\Memory\PagesWrittenPerSec" sampleRate="PT15S" unit="CountPerSecond">
        <annotation displayName="Page writes" locale="en-us"/>
      </PerformanceCounterConfiguration>
      <PerformanceCounterConfiguration counterSpecifier="\Memory\AvailableSwap" sampleRate="PT15S" unit="Bytes">
        <annotation displayName="Swap available" locale="en-us"/>
      </PerformanceCounterConfiguration>
      <PerformanceCounterConfiguration counterSpecifier="\Memory\PercentAvailableSwap" sampleRate="PT15S" unit="Percent">
        <annotation displayName="Swap percent available" locale="en-us"/>
      </PerformanceCounterConfiguration>
      <PerformanceCounterConfiguration counterSpecifier="\Memory\UsedSwap" sampleRate="PT15S" unit="Bytes">
        <annotation displayName="Swap used" locale="en-us"/>
      </PerformanceCounterConfiguration>
      <PerformanceCounterConfiguration counterSpecifier="\Memory\PercentUsedSwap" sampleRate="PT15S" unit="Percent">
        <annotation displayName="Swap percent used" locale="en-us"/>
      </PerformanceCounterConfiguration>
      <PerformanceCounterConfiguration counterSpecifier="\Processor\PercentIdleTime" sampleRate="PT15S" unit="Percent">
        <annotation displayName="CPU idle time" locale="en-us"/>
      </PerformanceCounterConfiguration>
      <PerformanceCounterConfiguration counterSpecifier="\Processor\PercentUserTime" sampleRate="PT15S" unit="Percent">
        <annotation displayName="CPU user time" locale="en-us"/>
      </PerformanceCounterConfiguration>
      <PerformanceCounterConfiguration counterSpecifier="\Processor\PercentNiceTime" sampleRate="PT15S" unit="Percent">
        <annotation displayName="CPU nice time" locale="en-us"/>
      </PerformanceCounterConfiguration>
      <PerformanceCounterConfiguration counterSpecifier="\Processor\PercentPrivilegedTime" sampleRate="PT15S" unit="Percent">
        <annotation displayName="CPU privileged time" locale="en-us"/>
      </PerformanceCounterConfiguration>
      <PerformanceCounterConfiguration counterSpecifier="\Processor\PercentInterruptTime" sampleRate="PT15S" unit="Percent">
        <annotation displayName="CPU interrupt time" locale="en-us"/>
      </PerformanceCounterConfiguration>
      <PerformanceCounterConfiguration counterSpecifier="\Processor\PercentDPCTime" sampleRate="PT15S" unit="Percent">
        <annotation displayName="CPU DPC time" locale="en-us"/>
      </PerformanceCounterConfiguration>
      <PerformanceCounterConfiguration counterSpecifier="\Processor\PercentProcessorTime" sampleRate="PT15S" unit="Percent">
        <annotation displayName="CPU percentage guest OS" locale="en-us"/>
      </PerformanceCounterConfiguration>
      <PerformanceCounterConfiguration counterSpecifier="\Processor\PercentIOWaitTime" sampleRate="PT15S" unit="Percent">
        <annotation displayName="CPU IO wait time" locale="en-us"/>
      </PerformanceCounterConfiguration>
      <PerformanceCounterConfiguration counterSpecifier="\PhysicalDisk\BytesPerSecond" sampleRate="PT15S" unit="BytesPerSecond">
        <annotation displayName="Disk total bytes" locale="en-us"/>
      </PerformanceCounterConfiguration>
      <PerformanceCounterConfiguration counterSpecifier="\PhysicalDisk\ReadBytesPerSecond" sampleRate="PT15S" unit="BytesPerSecond">
        <annotation displayName="Disk read guest OS" locale="en-us"/>
      </PerformanceCounterConfiguration>
      <PerformanceCounterConfiguration counterSpecifier="\PhysicalDisk\WriteBytesPerSecond" sampleRate="PT15S" unit="BytesPerSecond">
        <annotation displayName="Disk write guest OS" locale="en-us"/>
      </PerformanceCounterConfiguration>
      <PerformanceCounterConfiguration counterSpecifier="\PhysicalDisk\TransfersPerSecond" sampleRate="PT15S" unit="CountPerSecond">
        <annotation displayName="Disk transfers" locale="en-us"/>
      </PerformanceCounterConfiguration>
      <PerformanceCounterConfiguration counterSpecifier="\PhysicalDisk\ReadsPerSecond" sampleRate="PT15S" unit="CountPerSecond">
        <annotation displayName="Disk reads" locale="en-us"/>
      </PerformanceCounterConfiguration>
      <PerformanceCounterConfiguration counterSpecifier="\PhysicalDisk\WritesPerSecond" sampleRate="PT15S" unit="CountPerSecond">
        <annotation displayName="Disk writes" locale="en-us"/>
      </PerformanceCounterConfiguration>
      <PerformanceCounterConfiguration counterSpecifier="\PhysicalDisk\AverageReadTime" sampleRate="PT15S" unit="Seconds">
        <annotation displayName="Disk read time" locale="en-us"/>
      </PerformanceCounterConfiguration>
      <PerformanceCounterConfiguration counterSpecifier="\PhysicalDisk\AverageWriteTime" sampleRate="PT15S" unit="Seconds">
        <annotation displayName="Disk write time" locale="en-us"/>
      </PerformanceCounterConfiguration>
      <PerformanceCounterConfiguration counterSpecifier="\PhysicalDisk\AverageTransferTime" sampleRate="PT15S" unit="Seconds">
        <annotation displayName="Disk transfer time" locale="en-us"/>
      </PerformanceCounterConfiguration>
      <PerformanceCounterConfiguration counterSpecifier="\PhysicalDisk\AverageDiskQueueLength" sampleRate="PT15S" unit="Count">
        <annotation displayName="Disk queue length" locale="en-us"/>
      </PerformanceCounterConfiguration>
      <PerformanceCounterConfiguration counterSpecifier="\NetworkInterface\BytesTransmitted" sampleRate="PT15S" unit="Bytes">
        <annotation displayName="Network out guest OS" locale="en-us"/>
      </PerformanceCounterConfiguration>
      <PerformanceCounterConfiguration counterSpecifier="\NetworkInterface\BytesReceived" sampleRate="PT15S" unit="Bytes">
        <annotation displayName="Network in guest OS" locale="en-us"/>
      </PerformanceCounterConfiguration>
      <PerformanceCounterConfiguration counterSpecifier="\NetworkInterface\PacketsTransmitted" sampleRate="PT15S" unit="Count">
        <annotation displayName="Packets sent" locale="en-us"/>
      </PerformanceCounterConfiguration>
      <PerformanceCounterConfiguration counterSpecifier="\NetworkInterface\PacketsReceived" sampleRate="PT15S" unit="Count">
        <annotation displayName="Packets received" locale="en-us"/>
      </PerformanceCounterConfiguration>
      <PerformanceCounterConfiguration counterSpecifier="\NetworkInterface\BytesTotal" sampleRate="PT15S" unit="Bytes">
        <annotation displayName="Network total bytes" locale="en-us"/>
      </PerformanceCounterConfiguration>
      <PerformanceCounterConfiguration counterSpecifier="\NetworkInterface\TotalRxErrors" sampleRate="PT15S" unit="Count">
        <annotation displayName="Packets received errors" locale="en-us"/>
      </PerformanceCounterConfiguration>
      <PerformanceCounterConfiguration counterSpecifier="\NetworkInterface\TotalTxErrors" sampleRate="PT15S" unit="Count">
        <annotation displayName="Packets sent errors" locale="en-us"/>
      </PerformanceCounterConfiguration>
      <PerformanceCounterConfiguration counterSpecifier="\NetworkInterface\TotalCollisions" sampleRate="PT15S" unit="Count">
        <annotation displayName="Network collisions" locale="en-us"/>
      </PerformanceCounterConfiguration>
    </PerformanceCounters>
    <Metrics resourceId="${virtual_machine_id}">
      <MetricAggregation scheduledTransferPeriod="PT1H"/>
      <MetricAggregation scheduledTransferPeriod="PT1M"/>
    </Metrics>
  </DiagnosticMonitorConfiguration>
</WadCfg>