<?php

return [
    'fields' => [

        'heroBlock' => [
            'defaultTabName' => 'Additional Settings',
            'types' => [
                'text' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['headline', 'text'],
                    ], [
                        'label' => 'Format & Layout',
                        'fields' => ['eyebrow', 'anchor', 'layout', 'edges', 'background'],
                    ]],
                ],

                'textImage' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['headline', 'variant', 'text', 'images'],
                    ], [
                        'label' => 'Format & Layout',
                        'fields' => ['eyebrow', 'anchor', 'edges', 'background'],
                    ]],
                ],
            ]
        ],

        'sidebarBlocks' => [
            'defaultTabName' => 'Additional Settings',
            'types' => [
                'headline' => [
                    'tabs' => [[
                        'label' => 'Headline',
                        'fields' => ['headline'],
                    ], [
                        'label' => 'Format & Layout',
                        'fields' => ['eyebrow', 'anchor', 'layout', 'edges', 'background'],
                    ]],
                ],

                'text' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['text'],
                    ], [
                        'label' => 'Format & Layout',
                        'fields' => ['eyebrow', 'anchor', 'layout', 'edges', 'background'],
                    ]],
                ],

                'entries' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['text', 'records'],
                    ], [
                        'label' => 'Format & Layout',
                        'fields' => ['eyebrow', 'anchor', 'layout', 'edges', 'background'],
                    ]],
                ],
            ]
        ],

        'contentBlocks' => [
            'defaultTabName' => 'Additional Settings',
            // 'groups' => [[
            //     'label' => 'Basic Components',
            //     'types' => ['text', 'textImage'],
            // ], ],
            'types' => [
                'text' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['variant', 'text'],
                    ], [
                        'label' => 'Format & Layout',
                        'fields' => ['eyebrow', 'anchor', 'layout', 'edges', 'background'],
                    ]],
                ],

                'textImage' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['variant', 'text', 'images'],
                    ], [
                        'label' => 'Format & Layout',
                        'fields' => ['eyebrow', 'anchor', 'layout', 'edges', 'background'],
                    ]],
                ],

                'textText' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['text', 'text2'],
                    ], [
                        'label' => 'Format & Layout',
                        'fields' => ['eyebrow', 'anchor', 'layout', 'edges', 'background'],
                    ]],
                ],

                'image' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['images'],
                    ], [
                        'label' => 'Format & Layout',
                        'fields' => ['eyebrow', 'anchor', 'layout', 'edges', 'background'],
                    ]],
                ],

                'entries' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['text', 'items'],
                    ], [
                        'label' => 'Format & Layout',
                        'fields' => ['eyebrow', 'anchor', 'layout', 'edges', 'background'],
                    ]],
                ],

                'repeater' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['text', 'items'],
                    ], [
                        'label' => 'Format & Layout',
                        'fields' => ['eyebrow', 'anchor', 'layout', 'edges', 'background'],
                    ]],
                ],

                'revealer' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['text', 'items'],
                    ], [
                        'label' => 'Format & Layout',
                        'fields' => ['eyebrow', 'anchor', 'layout', 'edges', 'background'],
                    ]],
                ],
            ],
        ],
    ],
];