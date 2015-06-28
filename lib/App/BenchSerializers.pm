package App::BenchSerializers;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

our %data = (
    undef => {
        summary => 'undef',
        data => undef,
    },
    num => {
        summary => 'A single number (-1.23)',
        data => -1.23,
    },
    str1k => {
        summary => 'A string 1024-character long',
        data => 'a' x 1024,
    },
    array_int10 => {
        summary => 'A 10-element array containing ints',
        data => [1..10],
    },
    # XXX more data
);

our %contestants = (
    'JSON::PP' => {
        tags => ['json'],
        serialize => sub {
            JSON::PP::encode_json($_[0]);
        },
        deserialize => sub {
            JSON::PP::decode_json($_[0]);
        },
    },
    'JSON::XS' => {
        tags => ['json'],
        serialize => sub {
            JSON::XS::encode_json($_[0]);
        },
        deserialize => sub {
            JSON::XS::decode_json($_[0]);
        },
    },
    'JSON::MaybeXS' => {
        tags => ['json'],
        serialize => sub {
            JSON::MaybeXS::encode_json($_[0]);
        },
        deserialize => sub {
            JSON::MaybeXS::decode_json($_[0]);
        },
    },
    'JSON::Decode::Regexp' => {
        tags => ['json'],
        deserialize => sub {
            JSON::Decode::Regexp::from_json($_[0]);
        },
    },
    'JSON::Decode::Marpa' => {
        tags => ['json'],
        deserialize => sub {
            JSON::Decode::Marpa::from_json($_[0]);
        },
    },
    'Pegex::JSON' => {
        tags => ['json'],
        deserialize => sub {
            state $obj = Pegex::JSON->new;
            $obj->load($_[0]);
        },
    },

    'YAML::Old' => {
        tags => ['yaml'],
        serialize => sub {
            YAML::Old::Dump($_[0]);
        },
        deserialize => sub {
            YAML::Old::Load($_[0]);
        },
    },

    'YAML::Syck' => {
        tags => ['yaml'],
        serialize => sub {
            YAML::Syck::Dump($_[0]);
        },
        deserialize => sub {
            YAML::Syck::Load($_[0]);
        },
    },

    'YAML::XS' => {
        tags => ['yaml'],
        serialize => sub {
            YAML::XS::Dump($_[0]);
        },
        deserialize => sub {
            YAML::XS::Load($_[0]);
        },
    },

    'Storable' => {
        tags => ['binary', 'core'],
        serialize => sub {
            Storable::freeze($_[0]);
        },
        deserialize => sub {
            Storable::thaw($_[0]);
        },
    },

    'Sereal' => {
        tags => ['binary'],
        serialize => sub {
            Sereal::encode_sereal($_[0]);
        },
        deserialize => sub {
            Sereal::decode_sereal($_[0]);
        },
    },

    'Data::MessagePack' => {
        tags => ['binary'],
        serialize => sub {
            state $obj = Data::MessagePack->new;
            $obj->pack($_[0]);
        },
        deserialize => sub {
            state $obj = Data::MessagePack->new;
            $obj->unpack($_[0]);
        },
    },
);

1;
# ABSTRACT: Benchmark Perl data serialization modules

=head1 SYNOPSIS

See the included scripts:

#INSERT_EXECS_LIST
