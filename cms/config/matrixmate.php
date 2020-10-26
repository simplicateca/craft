<?php

return [
    'fields' => [
        'contentBlocks' => [
            'defaultTabName' => 'Misc',
            'groups' => [[
                'label' => 'Basic Components',
                'types' => ['text', 'textImage'],
            ], ],
            'types' => [
                'text' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['headline', 'headlineStyle', 'text'],
                    ], [
                        'label' => 'Buttons & Settings',
                        'fields' => ['buttons', 'layout', 'spacing', 'background'],
                    ]],
                ],

                'textImage' => [
                    'tabs' => [[
                        'label' => 'Content',
                        'fields' => ['headline', 'headlineStyle', 'text', 'images'],
                    ], [
                        'label' => 'Buttons & Settings',
                        'fields' => ['buttons', 'layout', 'spacing', 'background'],
                    ]],
                ],

                // 'news' => [
                //     'maxLimit' => 1,
                // ],
            ],
        ],
    ],
];