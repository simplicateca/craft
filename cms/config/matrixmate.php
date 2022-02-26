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
                        'fields' => ['headline', 'text', 'images'],
                    ], [
                        'label' => 'Format & Layout',
                        'fields' => ['eyebrow', 'anchor', 'layout', 'edges', 'background'],
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

                'textImage' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['text', 'images'],
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
                        'fields' => ['text', 'records'],
                    ], [
                        'label' => 'Format & Layout',
                        'fields' => ['eyebrow', 'anchor', 'layout', 'edges', 'background'],
                    ]],
                ],

                'features' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['text', 'features'],
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