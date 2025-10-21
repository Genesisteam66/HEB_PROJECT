<?php

/**
 * @file
 * Theme settings form for HEB Website theme.
 */

/**
 * Implements hook_form_system_theme_settings_alter().
 */
function hebwebsite_form_system_theme_settings_alter(&$form, \Drupal\Core\Form\FormStateInterface $form_state) {
  // Logo settings.
  $form['logo_settings'] = [
    '#type' => 'details',
    '#title' => t('Logo Settings'),
    '#open' => TRUE,
  ];
  
  $form['logo_settings']['logo_path'] = [
    '#type' => 'textfield',
    '#title' => t('Path to custom logo'),
    '#default_value' => theme_get_setting('logo_path'),
    '#description' => t('The path to the file you would like to use as your logo file instead of the default logo.'),
  ];

  // Social media settings.
  $form['social_media'] = [
    '#type' => 'details',
    '#title' => t('Social Media Links'),
    '#open' => TRUE,
  ];

  $social_platforms = [
    'facebook' => t('Facebook'),
    'instagram' => t('Instagram'),
    'tiktok' => t('TikTok'),
    'youtube' => t('YouTube'),
    'whatsapp' => t('WhatsApp'),
    'telegram' => t('Telegram'),
  ];

  foreach ($social_platforms as $platform => $label) {
    $form['social_media'][$platform] = [
      '#type' => 'textfield',
      '#title' => $label . ' ' . t('URL'),
      '#default_value' => theme_get_setting('social_media.' . $platform),
      '#description' => t('Enter the URL for your @platform profile.', ['@platform' => $label]),
    ];
    
    $form['social_media'][$platform . '_icon'] = [
      '#type' => 'textfield',
      '#title' => $label . ' ' . t('Icon Path'),
      '#default_value' => theme_get_setting('social_media_icons.' . $platform),
      '#description' => t('Enter the path to the @platform icon.', ['@platform' => $label]),
    ];
  }
}
