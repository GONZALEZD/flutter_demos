class ConsoleAttribute {
  final String console;
  final String attribute;

  ConsoleAttribute({this.console, this.attribute});
}

class Section {
  final String name;
  final List<ConsoleAttribute> attributes;

  int get itemCount => attributes.length;

  ConsoleAttribute operator [](int i) => attributes[i];

  Section({this.name, this.attributes});

  static List<Section> allData() {
    Map<String, List<ConsoleAttribute>> data = {};
    Console.all.forEach((console) {
      console.characteristics.forEach((key, value) {
        final values = data.containsKey(key) ? data[key] : <ConsoleAttribute>[];
        values.add(ConsoleAttribute(console: console.name, attribute: value));
        data[key] = values;
      });
    });
    return data
        .map((key, value) =>
            MapEntry(key, Section(name: key, attributes: value)))
        .values
        .toList();
  }
}

class Console {
  final String name;
  final String date;
  final String price;
  final String cpu;
  final String gpu;
  final String storage;
  final String memory;
  final String discPlayer;

  const Console(
      {this.name,
      this.date,
      this.price,
      this.cpu,
      this.gpu,
      this.storage,
      this.memory,
      this.discPlayer});

  Map<String, String> get characteristics => {
        'Release date': this.date,
        'Price': this.price,
        'CPU': this.cpu,
        'GPU': this.gpu,
        'Storage': this.storage,
        'Memory': this.memory,
        'Optical drive': this.discPlayer,
      };

  static final ps5 = Console(
    name: 'PS5',
    date: '12 nov. 2020',
    price: '499,00 \$US',
    cpu: '8x Zen 2 Cores at 3.5GHz (variable frequency)',
    gpu: '10.28 TFLOPs, 36 CUs at 2.23GHz (variable frequency) Custom RDNA 2 (Supports Ray Tracing and 3D Audio via Tempest Engine)',
    storage: '825 GB SSD',
    memory: '16 GB GDDR6 SDRAM',
    discPlayer: 'Blu-ray/DVD',
  );

  static final ps5DigitalEdition = Console(
    name: 'PS5 Digital Edition',
    date: '12 nov. 2020',
    price: '399,00 \$US',
    cpu: '8x Zen 2 Cores at 3.5GHz (variable frequency)',
    gpu: '10.28 TFLOPs, 36 CUs at 2.23GHz (variable frequency) Custom RDNA 2 (Supports Ray Tracing and 3D Audio via Tempest Engine)',
    storage: '825 GB SSD',
    memory: '16 GB GDDR6 SDRAM',
    discPlayer: ' - ',
  );

  static final xBoxSeriesX = Console(
    name: 'Xbox Series X',
    date: '10 nov. 2020',
    price: '499,99 €',
    cpu: '8x Cores @ 3.8 GHz (3.66 GHz w/ SMT) Custom Zen 2 CPU',
    gpu: '12 TFLOPS / 1.825 GHz RDNA 2 AMD / 52 CU',
    storage: '1 TB SSD',
    memory: '16 GB GDDR6 SDRAM',
    discPlayer: 'Blu-ray/DVD',
  );

  static final xBoxSeriesS = Console(
    name: 'Xbox Series S',
    date: '10 nov. 2020',
    price: '299,99 €',
    cpu: '8x Cores at 3.6 GHz (3.4 GHz w/ SMT) Custom Zen 2 CPU',
    gpu: '4 TFLOPS / 1.55 GHz RDNA 2 AMD / 20 CU',
    storage: '512 GB SSD (NVME)',
    memory: '10 GB GDDR6 SDRAM',
    discPlayer: ' - ',
  );

  static final nintendoSwitch = Console(
    name: 'Switch',
    date: '3 mars 2017',
    price: '299,99 \$US',
    cpu: 'Octa-core (4×ARM Cortex-A57 & 4×ARM Cortex-A53) @ 1.020 GHz',
    gpu:
        'Nvidia GM20B Maxwell-based GPU @ 307.2 - 384 MHz while undocked, 307.2 - 768 MHz while docked',
    storage: '32 GB Internal flash memory',
    memory: '8 GB',
    discPlayer: ' - ',
  );

  static final ps4Pro = Console(
    name: 'PS4 Pro',
    date: '2016 Nov 10',
    price: 'US\$399.99',
    cpu: 'Single-chip x86 AMD "Jaguar" processor, 8 cores, Clock speed 1.6GHz, A secondary Custom ARM CPU and RAM for background processing such as downloading and recording gameplay.',
    gpu: 'AMD Polaris 4,2 teraflops',
    storage: '1 TB',
    memory: '8 GB GDDR5',
    discPlayer: 'Blu-ray/DVD',
  );

  static final xBoxOneX = Console(
    name: 'XBOX One X',
    date: '2017 Nov 7',
    price: 'US\$499.00',
    cpu: 'Single-chip x86 AMD "Jaguar" processor, 8 cores, Clock speed 1.75GHz, 32MB of embedded SRAM memory.',
    gpu: 'AMD Polaris 6 teraflops',
    storage: '1 TB',
    memory: '12 GB GDDR5',
    discPlayer: 'Blu-ray,DVD,CD',
  );

  static final ps3 = Console(
    name: 'PS3',
    date: '2010 Jul 29',
    price: 'US\$349.99',
    cpu: '3.2 GHz Cell Broadband Engine 1 PPE & 7 SPEs',
    gpu: '550 MHz RSX Reality Synthesizer',
    storage: '320 GB',
    memory: '256 MB',
    discPlayer: 'Blu-ray',
  );

  static final xBox360 = Console(
    name: 'Xbox 360',
    date: '2010 Jun 18',
    price: 'US\$299.00',
    cpu: '3.2-GHz PowerPC Tri-Core Xenon GPU: 500 MHz ATI Xenos',
    gpu: '550 MHz ATI Xenos',
    storage: '320 GB',
    memory: '512 MB',
    discPlayer: 'DVD-DL',
  );

  static final wii = Console(
    name: 'Wii',
    date: '2006 Nov 19',
    price: 'US\$199.00',
    cpu: '729 MHz PowerPC Broadway',
    gpu: '243 MHz ATI Hollywood',
    storage: '512 MB',
    memory: '88 MB',
    discPlayer: 'Wii optical disc',
  );

  static List<Console> get all => [
        Console.ps5,
        Console.ps5DigitalEdition,
        Console.xBoxSeriesX,
        Console.xBoxSeriesS,
        Console.nintendoSwitch,
        Console.ps4Pro,
        Console.xBoxOneX,
        Console.xBox360,
        Console.ps3,
        Console.wii,
      ];
}
