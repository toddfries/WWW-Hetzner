This is mostly for reference.

Hetzner has a thorough [API](https://wiki.hetzner.de/index.php/Robot/en) description page.

A Hetzner::get("order/server_market/product?...") call returns an array of servers.
The server structure expands to this (as an example):

$VAR1 = {
          'product' => {
                         'price_setup' => '0.0000',
                         'cpu' => 'Intel Core i7-4770',
                         'fixed_price' => bless( do{\(my $o = 0)}, 'JSON::PP::Boolean' ),
                         'price_setup_vat' => '0.0000',
                         'price' => '35.2941',
                         'hdd_size' => 2048,
                         'dist' => [
                                     'Rescue system'
                                   ],
                         'description' => [
                                            'Intel Core i7-4770',
                                            '4x RAM 8192 MB DDR3',
                                            '2x HDD SATA 2,0 TB Enterprise'
                                          ],
                         'id' => 798115,
                         'price_vat' => '35.2941',
                         'datacenter' => 'FSN1-DC6',
                         'traffic' => '20 TB',
                         'hdd_count' => 2,
                         'cpu_benchmark' => 9840,
                         'memory_size' => 32,
                         'next_reduce' => 87637,
                         'lang' => [
                                     'en'
                                   ],
                         'name' => 'SB42',
                         'arch' => [
                                     64
                                   ]
                       }
        };

