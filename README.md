# Spree Atos/Sips

## Français

### Description
La gem spree_atos_sips permet d'intégrer simplement la méthode de paiement de Atos Worldline à votre site e-commerce Spree.

### Démonstration

site de démonstration: http://dotspree-atos.srvdev02.dotgee.fr/

### Installation

1. Pour l'installer, il suffit d'ajouter la ligne suivante à votre Gemfile.

<pre>
    gem 'spree_atos_sips', :git => 'https://github.com/Johann-dotgee/spree_atos_sips.git'
</pre>

2. Effectuez ensuite un bundle install

<pre>
	bundle install
</pre>

### Configuration

1. Rendez-vous sur votre panneau d'administration (http://monsite.com/admin)

2. Allez ensuite dans "Configuration", puis "Payment Methods"

3. Cliquez sur "Add New Payment Method"

4. Entrez les paramètres qui vous plaisent, choisissez "Spree::BillingIntegration::Atos::Sips" comme provider, puis enregistrez

5. De nouveaux champs sont présents, remplissez les (merchant id, banque)

6. Placez ensuite les fichiers (binaires, certificats, etc) selon l'architecture suivante dans votre projet rails:


* mon_commerce

* * lib

* * * atos
 
* * * * bin

* * * * * request

* * * * * response

* * * * banque

* * * * * certif.fr.identifiant

* * * * * params.xml

* * * * * parmcom.identifiant

* * * * * parmcom.banque

* * * * * pathfile



## English

### Description
The spree_atos_sips gem allows you to put easily the payment method from Atos Worldline in your Spree e-commerce website.

### Display

display website: http://dotspree-atos.srvdev02.dotgee.fr/


### Installation

1. To install the gem, just put the following in your Gemfile.

<pre>
    gem 'spree_atos_sips', :git => 'https://github.com/Johann-dotgee/spree_atos_sips.git'
</pre>

2. Then, bundle install

<pre>
	bundle install
</pre>

### Configuration

1. First, go on your administration pannel (http://monsite.com/admin)

2. Then, click on "Configuration", and "Payment Methods"

3. After this, click on "Add New Payment Method"

4. Configure the name, description, etc as you want and just choose "Spree::BillingIntegration::Atos::Sips" as provider. Then, save.

5. Some new fields appeared (merchant id, banque), fill them.

6. Finally, put the files the bank gave you (binaries, certificates, etc) on the right place, according to the following architecture:


* mon_commerce

* * lib

* * * atos
 
* * * * bin

* * * * * request

* * * * * response

* * * * banque

* * * * * certif.fr.identifiant

* * * * * params.xml

* * * * * parmcom.identifiant

* * * * * parmcom.banque

* * * * * pathfile



Copyright (c) 2011 [name of extension creator], released under the New BSD License
