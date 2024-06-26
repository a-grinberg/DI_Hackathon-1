toc.dat                                                                                             0000600 0004000 0002000 00000033564 14626117060 0014455 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        PGDMP       #    )                |           CRM    14.5    14.5 0    %           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false         &           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false         '           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false         (           1262    26531    CRM    DATABASE     b   CREATE DATABASE "CRM" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1252';
    DROP DATABASE "CRM";
                postgres    false         �            1255    26769    generate_user_data()    FUNCTION       CREATE FUNCTION public.generate_user_data() RETURNS TABLE(name character varying, last_name character varying, phone character varying, address character varying, email character varying, role_id integer, password character varying, user_name character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY
    SELECT
      faker.name.find_name() AS name,
      faker.name.last_name() AS last_name,
      faker.phone.phone_number() AS phone,
      faker.address.street_address() || ', ' || faker.address.city() || ', ' || faker.address.country_code() AS address,
      faker.internet.email() AS email,
      FLOOR(RANDOM(2) * (SELECT MAX(id) FROM roles)) + 1 AS role_id,
	faker.phone.phone_number() AS password,
      faker.internet.user_name() AS user_name;
END;
$$;
 +   DROP FUNCTION public.generate_user_data();
       public          postgres    false         �            1259    27004    comments    TABLE     �   CREATE TABLE public.comments (
    id integer NOT NULL,
    deal_id integer NOT NULL,
    user_id integer NOT NULL,
    comment text NOT NULL,
    create_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.comments;
       public         heap    postgres    false         �            1259    27003    comments_id_seq    SEQUENCE     �   CREATE SEQUENCE public.comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.comments_id_seq;
       public          postgres    false    218         )           0    0    comments_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;
          public          postgres    false    217         �            1259    26977    deals    TABLE     A  CREATE TABLE public.deals (
    id integer NOT NULL,
    deal_dscription text,
    client_id integer,
    manager_id integer NOT NULL,
    status_id integer DEFAULT 1 NOT NULL,
    create_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.deals;
       public         heap    postgres    false         �            1259    26976    deals_id_seq    SEQUENCE     �   CREATE SEQUENCE public.deals_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.deals_id_seq;
       public          postgres    false    216         *           0    0    deals_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.deals_id_seq OWNED BY public.deals.id;
          public          postgres    false    215         �            1259    26945    roles    TABLE     e   CREATE TABLE public.roles (
    id integer NOT NULL,
    role_name character varying(50) NOT NULL
);
    DROP TABLE public.roles;
       public         heap    postgres    false         �            1259    26944    roles_id_seq    SEQUENCE     �   CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.roles_id_seq;
       public          postgres    false    210         +           0    0    roles_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;
          public          postgres    false    209         �            1259    26952    status    TABLE     h   CREATE TABLE public.status (
    id integer NOT NULL,
    status_name character varying(50) NOT NULL
);
    DROP TABLE public.status;
       public         heap    postgres    false         �            1259    26951    status_id_seq    SEQUENCE     �   CREATE SEQUENCE public.status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.status_id_seq;
       public          postgres    false    212         ,           0    0    status_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.status_id_seq OWNED BY public.status.id;
          public          postgres    false    211         �            1259    26959    users    TABLE     y  CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    phone character varying(20),
    address character varying(255),
    email character varying(320) NOT NULL,
    role_id integer NOT NULL,
    password character varying(255) NOT NULL,
    user_name character varying(255) NOT NULL
);
    DROP TABLE public.users;
       public         heap    postgres    false         �            1259    26958    users_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public          postgres    false    214         -           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public          postgres    false    213         x           2604    27007    comments id    DEFAULT     j   ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);
 :   ALTER TABLE public.comments ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    217    218    218         t           2604    26980    deals id    DEFAULT     d   ALTER TABLE ONLY public.deals ALTER COLUMN id SET DEFAULT nextval('public.deals_id_seq'::regclass);
 7   ALTER TABLE public.deals ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    215    216         q           2604    26948    roles id    DEFAULT     d   ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);
 7   ALTER TABLE public.roles ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    209    210    210         r           2604    26955 	   status id    DEFAULT     f   ALTER TABLE ONLY public.status ALTER COLUMN id SET DEFAULT nextval('public.status_id_seq'::regclass);
 8   ALTER TABLE public.status ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    212    211    212         s           2604    26962    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    213    214    214         "          0    27004    comments 
   TABLE DATA           N   COPY public.comments (id, deal_id, user_id, comment, create_date) FROM stdin;
    public          postgres    false    218       3362.dat            0    26977    deals 
   TABLE DATA           p   COPY public.deals (id, deal_dscription, client_id, manager_id, status_id, create_date, update_date) FROM stdin;
    public          postgres    false    216       3360.dat           0    26945    roles 
   TABLE DATA           .   COPY public.roles (id, role_name) FROM stdin;
    public          postgres    false    210       3354.dat           0    26952    status 
   TABLE DATA           1   COPY public.status (id, status_name) FROM stdin;
    public          postgres    false    212       3356.dat           0    26959    users 
   TABLE DATA           i   COPY public.users (id, name, last_name, phone, address, email, role_id, password, user_name) FROM stdin;
    public          postgres    false    214       3358.dat .           0    0    comments_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.comments_id_seq', 100, true);
          public          postgres    false    217         /           0    0    deals_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.deals_id_seq', 103, true);
          public          postgres    false    215         0           0    0    roles_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.roles_id_seq', 2, true);
          public          postgres    false    209         1           0    0    status_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.status_id_seq', 6, true);
          public          postgres    false    211         2           0    0    users_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.users_id_seq', 50, true);
          public          postgres    false    213         �           2606    27012    comments comments_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.comments DROP CONSTRAINT comments_pkey;
       public            postgres    false    218         �           2606    26987    deals deals_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.deals
    ADD CONSTRAINT deals_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.deals DROP CONSTRAINT deals_pkey;
       public            postgres    false    216         {           2606    26950    roles roles_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.roles DROP CONSTRAINT roles_pkey;
       public            postgres    false    210         }           2606    26957    status status_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.status
    ADD CONSTRAINT status_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.status DROP CONSTRAINT status_pkey;
       public            postgres    false    212                    2606    26968    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public            postgres    false    214         �           2606    26966    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    214         �           2606    26970    users users_user_name_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_user_name_key UNIQUE (user_name);
 C   ALTER TABLE ONLY public.users DROP CONSTRAINT users_user_name_key;
       public            postgres    false    214         �           2606    27013    comments comments_deal_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_deal_id_fkey FOREIGN KEY (deal_id) REFERENCES public.deals(id) ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.comments DROP CONSTRAINT comments_deal_id_fkey;
       public          postgres    false    218    3205    216         �           2606    27018    comments comments_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.comments DROP CONSTRAINT comments_user_id_fkey;
       public          postgres    false    214    218    3201         �           2606    26988    deals deals_client_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.deals
    ADD CONSTRAINT deals_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.users(id) ON DELETE SET NULL;
 D   ALTER TABLE ONLY public.deals DROP CONSTRAINT deals_client_id_fkey;
       public          postgres    false    3201    214    216         �           2606    26993    deals deals_manager_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.deals
    ADD CONSTRAINT deals_manager_id_fkey FOREIGN KEY (manager_id) REFERENCES public.users(id) ON DELETE SET NULL;
 E   ALTER TABLE ONLY public.deals DROP CONSTRAINT deals_manager_id_fkey;
       public          postgres    false    3201    216    214         �           2606    26998    deals deals_status_id_fkey    FK CONSTRAINT     |   ALTER TABLE ONLY public.deals
    ADD CONSTRAINT deals_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.status(id);
 D   ALTER TABLE ONLY public.deals DROP CONSTRAINT deals_status_id_fkey;
       public          postgres    false    212    216    3197         �           2606    26971    users users_role_id_fkey    FK CONSTRAINT     w   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_role_id_fkey;
       public          postgres    false    210    3195    214                                                                                                                                                    3362.dat                                                                                            0000600 0004000 0002000 00000045266 14626117060 0014267 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	16	37	Aliquam deserunt eius enim ut adipisci architecto. Nihil porro magnam mollitia rerum iste similique. Maiores dolor consequatur accusantium itaque.	2024-05-29 20:27:05.518525
2	49	20	Eum rem omnis sapiente vitae. Debitis quidem eos reiciendis fuga deleniti. Dolores doloribus commodi consequuntur nostrum. Rerum minus qui hic quis autem quidem.	2024-05-29 20:27:05.528712
3	24	5	Architecto non quae facilis facilis possimus quasi. Placeat velit in ipsum placeat dolor mollitia. Voluptatem eligendi totam quidem atque deserunt tempora.	2024-05-29 20:27:05.529948
4	92	25	Aliquid eum accusamus vitae corporis. Fugit debitis officia quia accusantium voluptatem.	2024-05-29 20:27:05.530991
5	80	16	Non voluptas fugit tempora culpa. Voluptates id consequatur ex unde debitis veritatis nemo. Adipisci assumenda nostrum minus porro aut fuga rem.	2024-05-29 20:27:05.531926
6	73	7	Architecto fugit eaque sed neque suscipit temporibus. At nisi dolorum provident quo nesciunt. Magnam ratione laboriosam deleniti distinctio exercitationem totam suscipit harum.	2024-05-29 20:27:05.532711
7	90	31	Reiciendis nostrum ea reiciendis. Error aliquam quisquam iure quia dolor. Vitae cum voluptatem adipisci saepe minima tempore qui maxime.	2024-05-29 20:27:05.53337
8	74	26	Quod ea quae voluptate. Blanditiis eligendi ex commodi ab labore deserunt. Autem nostrum sapiente cupiditate vero excepturi exercitationem. Fuga inventore nemo deleniti.	2024-05-29 20:27:05.534127
9	65	22	Repellat repellendus neque facere dolor aliquid. Omnis dolorem accusantium quasi possimus quaerat sint. Debitis porro culpa quidem consequuntur ea vero adipisci quia.	2024-05-29 20:27:05.534936
10	10	21	Iste officiis fuga magni illo sequi nihil. Vero velit iure quas tempore repellat aspernatur. Aspernatur maxime eveniet dolore.	2024-05-29 20:27:05.535631
11	73	37	Accusamus sunt blanditiis deleniti cupiditate vel. Dolorum ipsum fugiat rem. Cum asperiores eligendi facere dolor necessitatibus nam. Ipsam quaerat labore eius cupiditate.	2024-05-29 20:27:05.536658
12	60	33	Laborum minima ea beatae quod repellat tenetur. Odio eos blanditiis voluptas maiores quisquam incidunt magni. Culpa culpa nam ipsa et voluptas explicabo corrupti esse. Ipsam deserunt in ab saepe.	2024-05-29 20:27:05.537749
13	3	28	Reiciendis officia voluptates soluta consequuntur quos. Facere libero accusamus at aliquid culpa voluptatum eius. Quo nihil aut possimus earum impedit doloribus.	2024-05-29 20:27:05.538859
14	14	5	Commodi expedita molestiae nesciunt. Facere dolorum harum labore sed totam. Magnam necessitatibus nostrum beatae autem. Nam cum numquam cumque nulla.	2024-05-29 20:27:05.539555
15	90	3	Cupiditate assumenda eligendi excepturi nihil eos laudantium accusamus. Vel nisi eos inventore. Totam provident soluta consequuntur et nobis in magni quisquam. Laboriosam molestiae quos consectetur.	2024-05-29 20:27:05.540221
16	65	21	Minus in architecto impedit placeat fugit quidem id at. Ipsam incidunt iure eos. Molestias quis cupiditate modi itaque magni sapiente. Natus ducimus ducimus fuga dignissimos quae.	2024-05-29 20:27:05.541033
17	36	5	Consequuntur nulla quisquam voluptatum. Nesciunt et unde vitae voluptates veniam officia.	2024-05-29 20:27:05.541955
18	87	8	Repudiandae quisquam nulla natus quam nostrum. Beatae ex voluptatibus sit illo. Alias vel minus illum dolorum.	2024-05-29 20:27:05.542876
19	35	35	Corporis pariatur velit hic a. Neque assumenda recusandae consectetur dolorem. Necessitatibus vitae asperiores ab eligendi eum. Similique eius iste natus delectus consequatur laborum labore.	2024-05-29 20:27:05.543664
20	54	26	In laborum quia magni assumenda. Pariatur modi et aspernatur fuga repellat. Est veniam unde mollitia assumenda laudantium voluptate perferendis. Delectus at excepturi id repudiandae incidunt.	2024-05-29 20:27:05.544237
21	80	13	Eum explicabo fugiat modi reprehenderit tenetur ratione. Voluptate quidem voluptates ut blanditiis vel. Accusamus corrupti nam corrupti sequi. Cupiditate maiores magni ex aspernatur iure.	2024-05-29 20:27:05.544904
22	46	27	Doloribus reprehenderit possimus nobis itaque. Illo ipsam ullam eius qui. Sapiente voluptatum ad nobis accusantium corporis. Ad eius qui non placeat asperiores laborum.	2024-05-29 20:27:05.545883
23	59	17	Vel asperiores distinctio soluta quisquam eligendi similique. Ipsum accusamus optio ab sed cum odit soluta. Porro officia possimus minus voluptate quidem.	2024-05-29 20:27:05.546625
24	88	33	Est minima doloremque iste. Dolor asperiores ea culpa dolorem. Amet quibusdam delectus aliquid perspiciatis rerum beatae et.	2024-05-29 20:27:05.547335
25	21	27	Quis culpa quibusdam quisquam quam inventore culpa exercitationem iusto. Veniam ullam sunt quisquam cupiditate. Similique quibusdam hic velit temporibus officia.	2024-05-29 20:27:05.547944
26	80	28	Sint nulla voluptate repellendus nobis. Quia nesciunt iusto nemo quam quisquam. Dignissimos explicabo illum facere odit nesciunt consectetur sint.	2024-05-29 20:27:05.548563
27	60	16	Similique ducimus ea alias inventore voluptatem tenetur. Quae facilis repudiandae corrupti totam. Illum nam porro inventore incidunt perspiciatis nemo.	2024-05-29 20:27:05.54926
28	39	11	Ipsam sequi expedita consequatur. Possimus sed exercitationem quia id occaecati quisquam. Sequi excepturi tempora quo quod ex unde magni. Vel beatae earum fugiat aut soluta ad pariatur.	2024-05-29 20:27:05.550122
29	32	20	Eum sint pariatur quidem recusandae earum. Delectus sit consectetur quos totam. Aut accusantium nisi distinctio corporis similique. Unde veritatis vitae reprehenderit dignissimos maiores voluptas.	2024-05-29 20:27:05.551775
30	53	11	Fuga tempore sapiente ipsum est. Eos tempore tempora ipsum et possimus debitis est. Facilis harum rem quisquam. Illo voluptatem officiis vitae.	2024-05-29 20:27:05.552774
31	41	30	Odio fugiat maxime eos eius laboriosam explicabo. Natus amet sunt laboriosam. Aperiam dignissimos quas quis fugit et aliquam. Ab esse qui laborum tempora voluptatem ad.	2024-05-29 20:27:05.553573
32	74	5	In velit corrupti aliquam iste. Illo officiis magnam omnis voluptatem facilis consectetur. Necessitatibus sit modi exercitationem quasi quia eum itaque.	2024-05-29 20:27:05.554301
33	19	29	Quisquam delectus quae inventore ullam. Cum voluptatibus veritatis asperiores fuga iste tenetur. Aspernatur error minus itaque. Sequi corporis est corrupti facere libero harum.	2024-05-29 20:27:05.55538
34	21	3	In nesciunt voluptatum inventore dolorem magni atque occaecati. A hic sequi sunt ex quidem omnis. Consequuntur asperiores explicabo saepe ipsa iure facere cum eligendi.	2024-05-29 20:27:05.556844
35	60	8	Nihil eveniet doloribus rerum eos corporis. Molestias molestiae rerum laborum sequi accusantium nisi. Rerum pariatur voluptatum impedit tempore necessitatibus. Explicabo optio sit quas a aut nemo.	2024-05-29 20:27:05.557902
36	46	25	Sit iusto rem fugit. Cupiditate repudiandae rerum eum quasi. Quam eos cumque asperiores ut illo placeat. Quam sint ducimus assumenda.	2024-05-29 20:27:05.55909
37	24	34	Ducimus quisquam amet corrupti eum ratione. Quos cupiditate expedita quis debitis ea rerum. Minus rem porro reiciendis delectus provident.	2024-05-29 20:27:05.559851
38	11	28	Eius ab tempore iure repellat eius eos beatae dicta. Illo tempora mollitia cupiditate quisquam recusandae enim iusto. Sint libero expedita et excepturi.	2024-05-29 20:27:05.560553
39	21	28	Excepturi perferendis id nisi veniam numquam repellat rem. Nam incidunt quaerat iure magni veniam voluptatibus. Rem non magnam necessitatibus magnam rerum libero ea.	2024-05-29 20:27:05.561408
40	97	21	Doloribus officia ratione adipisci quae natus exercitationem. Nostrum at officia temporibus iusto. Animi quaerat quaerat qui excepturi voluptate doloremque est.	2024-05-29 20:27:05.563249
41	43	31	Itaque est tenetur quia facere itaque. Nulla hic odio praesentium error qui. Impedit nobis atque enim perferendis. Facere neque veniam voluptas tenetur porro neque debitis.	2024-05-29 20:27:05.564985
42	78	10	Voluptate consequuntur sed voluptatem quasi minima ipsum quis perferendis. Facere omnis molestiae est itaque ab. Nostrum vitae ipsa saepe.	2024-05-29 20:27:05.567016
43	58	23	Ratione voluptas quisquam maxime. Accusantium id pariatur at magni et. Incidunt voluptates accusantium ea molestias aspernatur repellendus.	2024-05-29 20:27:05.568147
44	88	19	Illum dolores quod sunt ipsam voluptate voluptatibus placeat. Necessitatibus aspernatur quisquam maiores nemo sit. Quod quaerat harum illum suscipit eaque. Beatae alias nemo aperiam tempora porro.	2024-05-29 20:27:05.569384
45	91	32	Aliquid voluptas officia quod provident doloremque sequi eius voluptatem. Laboriosam quod distinctio repellat. Velit natus ullam quas earum quos.	2024-05-29 20:27:05.571121
46	43	12	Unde minima incidunt praesentium doloremque porro eveniet sequi consequuntur. Laboriosam fugiat sapiente modi. Reprehenderit sequi facilis natus sequi facilis. Voluptates porro molestias ipsam.	2024-05-29 20:27:05.572174
47	42	24	Ab nobis reiciendis commodi debitis cum. Consectetur porro eum et officiis.	2024-05-29 20:27:05.573123
48	8	15	Minima consequuntur non id blanditiis. Porro inventore minima exercitationem laborum. Necessitatibus nemo corrupti minus explicabo nobis illo ipsa.	2024-05-29 20:27:05.573862
49	45	26	Maiores sunt numquam repellendus impedit maxime. Debitis maxime quaerat inventore accusamus voluptates quibusdam ipsum. Sint sunt consectetur cumque quis. Commodi beatae ut temporibus cum vel ab hic.	2024-05-29 20:27:05.574663
50	85	21	Totam aliquam magnam aliquam accusamus mollitia natus unde quisquam. Eos expedita deserunt fugit blanditiis possimus doloribus omnis similique. Consectetur rem laborum repellat quibusdam facere.	2024-05-29 20:27:05.575688
51	4	19	Nam eius doloribus aperiam officia est perspiciatis illum. Odio natus accusantium unde cumque dolor. Cumque quidem numquam perferendis. Corporis magnam optio tempora corrupti itaque.	2024-05-29 20:27:05.576824
52	85	22	Ipsa delectus ipsam enim alias rerum tempore. Soluta reprehenderit nam maiores illum asperiores. Nostrum rerum nemo adipisci quae quibusdam cupiditate. Aspernatur mollitia eaque fugit.	2024-05-29 20:27:05.579058
53	33	24	Aut voluptatibus magni expedita voluptatibus. Saepe tempore voluptatibus quam iure ipsum animi.	2024-05-29 20:27:05.580308
54	62	30	Provident est officiis blanditiis reiciendis aliquid aliquid et. Provident maxime distinctio est dolore asperiores expedita. Adipisci excepturi rem exercitationem porro.	2024-05-29 20:27:05.581342
55	98	34	Esse corporis officiis cupiditate animi vel. Quae rem illo similique quo id. Provident quas repellat praesentium aperiam. Ullam aspernatur quo quidem minus consequatur minima error.	2024-05-29 20:27:05.582534
56	5	36	Quaerat eum eius cum perspiciatis ad. Odio nesciunt dolore distinctio porro recusandae inventore. Reprehenderit illo debitis commodi deserunt officia officia.	2024-05-29 20:27:05.584142
57	66	12	Dolor error quam dolore repellat architecto voluptatum. Repellendus est inventore officiis exercitationem nam quod. Soluta et ipsa velit in quisquam dolorum. Neque voluptatem recusandae minus unde.	2024-05-29 20:27:05.585484
58	10	15	Consequatur nulla vitae adipisci magnam aliquid explicabo. Reprehenderit dicta deserunt explicabo animi quisquam blanditiis amet perferendis. Cupiditate totam maiores dolorum.	2024-05-29 20:27:05.586747
59	78	13	Harum fugiat ex quaerat corrupti dolorem. Laboriosam est iure laboriosam officiis quos.	2024-05-29 20:27:05.587683
60	83	13	Cumque a illum repudiandae unde. Excepturi commodi quo tempore rerum neque placeat accusamus. Architecto consectetur maiores necessitatibus quos.	2024-05-29 20:27:05.588488
61	88	19	Dolorem neque tempore nisi unde optio provident. Voluptatibus odio voluptatum nesciunt est.	2024-05-29 20:27:05.589331
62	20	11	Vitae molestiae sapiente culpa harum commodi. Non quis aperiam repudiandae excepturi nesciunt occaecati deserunt. Neque dolores eveniet tenetur perferendis voluptatum est.	2024-05-29 20:27:05.590396
63	2	32	Quod error dignissimos cum fugit. Eaque unde cupiditate odit possimus eum qui doloremque. Harum distinctio dicta corporis inventore odit ratione in.	2024-05-29 20:27:05.592257
64	53	17	Voluptatibus commodi doloribus vitae molestiae quisquam a. Dolorum minima ad dolore dignissimos eum. Commodi quisquam quas ipsam laboriosam vero voluptatum ratione impedit.	2024-05-29 20:27:05.593504
65	58	9	Laborum deleniti error eius recusandae quibusdam. Dolore quia rerum velit qui. Atque exercitationem eaque pariatur nisi voluptatum. Rem recusandae cum animi ipsum ad aperiam.	2024-05-29 20:27:05.594755
66	16	16	Error quo ut molestias dolore occaecati quis. Ipsum iste mollitia fuga saepe officia.	2024-05-29 20:27:05.596739
67	84	37	Beatae eum deserunt sint sunt deleniti totam quae dolorem. Eaque minima incidunt eaque deleniti fugiat suscipit necessitatibus earum. Eum totam cupiditate rem non.	2024-05-29 20:27:05.597978
68	63	26	Placeat placeat cupiditate voluptatibus autem omnis. Ad optio iure distinctio eum eos quos. Iste corrupti sit aperiam in cupiditate officia nulla.	2024-05-29 20:27:05.599246
69	85	17	Eos dicta quo ab molestias modi nobis numquam. Aliquid odit nulla tempora dolorem. Dignissimos accusamus quae aspernatur ab. Sint repellendus totam recusandae.	2024-05-29 20:27:05.600746
70	2	29	Ex facere veritatis odit reprehenderit beatae. Nihil voluptate eveniet modi rem facilis. Eos odio voluptatum nisi illum fuga. Qui odio voluptate assumenda laboriosam tempora odio occaecati a.	2024-05-29 20:27:05.601964
71	54	15	Dolores accusamus facere quia facere rem excepturi. Debitis nemo commodi minima. Quae libero voluptas odit dolorem cum quae.	2024-05-29 20:27:05.603017
72	60	36	Voluptatem cupiditate dicta magni maiores minus. Unde doloremque aut dicta quibusdam provident illum a assumenda. Inventore nisi hic praesentium ullam.	2024-05-29 20:27:05.604277
73	75	23	Quo doloremque temporibus consectetur sapiente. Illo consequatur reprehenderit maiores accusamus tempore. Incidunt error quasi laboriosam totam consequuntur unde maxime est.	2024-05-29 20:27:05.60622
74	75	29	Quis ducimus quibusdam provident porro quod. Rem enim veritatis esse nobis nobis. At facilis veritatis minus corporis voluptatum ab vero animi. Aperiam eaque beatae ratione saepe.	2024-05-29 20:27:05.607535
75	11	15	Quae blanditiis ipsam voluptates ut. Tenetur maiores aliquid at iste dolore expedita minima. Quasi ex iste necessitatibus quia.	2024-05-29 20:27:05.608666
76	68	36	Id voluptatem vel est vel. Tempore rem voluptatibus blanditiis voluptates. Error possimus nihil facilis fugit. Amet officiis nisi molestias hic quae laborum.	2024-05-29 20:27:05.609925
77	86	36	Et ipsam ipsum animi ad molestias architecto. Porro natus hic laudantium voluptatibus.	2024-05-29 20:27:05.610857
78	59	17	Eius minus illo officia voluptas laboriosam reiciendis ab. Amet sit illum fugiat accusantium. Maiores placeat sapiente laboriosam ipsam.	2024-05-29 20:27:05.611893
79	90	31	Dicta quam iure repudiandae aut culpa exercitationem totam. Vel deleniti ipsam sint modi aliquid doloribus. Consectetur nisi aspernatur eveniet aliquam odio expedita perferendis nihil.	2024-05-29 20:27:05.61285
80	65	15	Sequi at numquam quibusdam repellendus. Quod beatae praesentium necessitatibus.\nRatione animi sapiente rem nam molestiae. Occaecati impedit asperiores odit. Qui ea quos odit aut sapiente ad.	2024-05-29 20:27:05.613763
81	71	27	Architecto dolores deleniti laboriosam amet dignissimos. Veritatis quia mollitia sed in sed. Illo occaecati voluptates sequi eligendi.	2024-05-29 20:27:05.614518
82	19	27	Rem ut minus ea omnis quaerat commodi repudiandae. Beatae corporis maxime provident odio nulla. Mollitia quasi sequi unde atque voluptates. Nemo rem quia nihil sit maiores temporibus.	2024-05-29 20:27:05.615445
83	35	9	Id corrupti cum commodi beatae dolor. Omnis occaecati odit sit natus dolorem inventore minus.	2024-05-29 20:27:05.61627
84	25	19	Repellendus totam consequuntur illum odit quibusdam consequatur alias. Veritatis quasi nobis veniam sit tempore. At consequatur dignissimos assumenda ipsam.	2024-05-29 20:27:05.617647
85	42	8	Perspiciatis quasi magni labore. Sint eos laborum ipsa sapiente. Iste autem fugit recusandae iure perferendis earum.	2024-05-29 20:27:05.619535
86	84	29	Distinctio soluta repudiandae nemo impedit facere consequuntur reiciendis. Pariatur et voluptate culpa omnis. Placeat commodi neque deserunt deleniti praesentium vel.	2024-05-29 20:27:05.620576
87	63	23	Placeat quia soluta dolorum beatae nisi voluptas aliquid. Dolor fugiat perferendis fugiat harum suscipit. Asperiores quidem necessitatibus aperiam recusandae corrupti eos amet.	2024-05-29 20:27:05.621405
88	87	27	Voluptates labore numquam sunt magnam. Dolore necessitatibus quidem amet nihil praesentium laudantium. Dolorem minus ipsum ex.	2024-05-29 20:27:05.622253
89	63	13	Delectus dolorem necessitatibus eos unde amet iste mollitia. Nostrum harum odio quo omnis eius vitae. Quia est quasi quam sint assumenda sequi consequatur. Neque culpa doloribus rerum.	2024-05-29 20:27:05.62361
90	74	18	Numquam molestiae fuga nobis officiis. Ullam nostrum accusantium atque atque quo unde maxime eaque. Deserunt minus vel veritatis.	2024-05-29 20:27:05.624722
91	55	10	Deleniti odit dolores debitis dolor magnam. Placeat ut iure eos dolores. Amet sequi ad blanditiis earum nam cupiditate.	2024-05-29 20:27:05.625807
92	65	24	Veniam maxime cumque repellendus numquam itaque id. Consectetur beatae cum natus exercitationem eius cumque. Ab dolorem id a. Enim adipisci id eos.	2024-05-29 20:27:05.626852
93	43	19	Vel atque possimus ab ab sunt dolores optio. Quibusdam doloribus aspernatur tenetur.	2024-05-29 20:27:05.627887
94	26	21	Nam esse suscipit magnam reprehenderit illo dolores odit. Sunt numquam doloribus nemo. Officia tenetur iusto ullam iusto officia tenetur.	2024-05-29 20:27:05.629081
95	98	20	Omnis illo laborum earum dolor voluptatibus officiis corrupti. Illo doloribus commodi sit. Tempora repudiandae fuga magni voluptatem dolorem quidem reiciendis. Cupiditate at laboriosam impedit.	2024-05-29 20:27:05.630178
96	13	24	Odit doloribus inventore exercitationem quasi saepe veritatis perferendis. Dolores voluptate deserunt nisi. Voluptates veritatis animi mollitia excepturi.	2024-05-29 20:27:05.631318
97	28	30	Consectetur molestias tempora doloribus voluptatibus. Labore nulla cum deserunt. Adipisci incidunt omnis dicta asperiores sit libero ab. Pariatur velit debitis quaerat ipsam nulla cumque.	2024-05-29 20:27:05.633055
98	31	8	Distinctio amet quo iste minima. Sapiente quisquam itaque quae veniam at ullam in. Ad eligendi quisquam consequatur officia beatae.	2024-05-29 20:27:05.633972
99	83	29	Porro doloremque velit aut possimus eaque aperiam. Iure doloribus debitis dolor ipsum. Quod cum odit placeat labore. Nemo voluptas a sint asperiores ex a quam exercitationem.	2024-05-29 20:27:05.635007
100	37	25	Ullam maxime repudiandae placeat. Rerum voluptas magnam architecto eaque placeat iusto soluta similique. Sequi saepe id asperiores ipsam voluptate temporibus beatae.	2024-05-29 20:27:05.636328
\.


                                                                                                                                                                                                                                                                                                                                          3360.dat                                                                                            0000600 0004000 0002000 00000052232 14626117060 0014254 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Sequi a quisquam inventore dicta. Assumenda facilis sapiente provident distinctio voluptatibus perferendis. Vero sint voluptates porro id deserunt repellendus dicta facilis.	33	1	1	2024-05-29 20:19:54.162629	2024-05-29 20:19:54.162629
2	Eaque dolorum quisquam nihil officia. Repellat pariatur molestias deserunt voluptatibus ex rerum ea vero. Numquam iste enim inventore officiis. Incidunt occaecati natus excepturi veritatis.	26	1	1	2024-05-29 20:19:54.166442	2024-05-29 20:19:54.166442
3	Assumenda molestiae sit quia assumenda veniam natus aut. Quam eveniet optio porro aut. Deleniti illo sint nisi deserunt quis. Possimus quae illum quas sed deleniti.	37	1	1	2024-05-29 20:19:54.16872	2024-05-29 20:19:54.16872
4	Ex repudiandae blanditiis repudiandae impedit eos quis. Dolor dolores optio a. Rem dolor aperiam adipisci ut suscipit quasi.	21	1	1	2024-05-29 20:19:54.170691	2024-05-29 20:19:54.170691
6	Facilis vero nulla eos temporibus minima. Suscipit aliquam quo delectus accusamus alias iusto. Incidunt facere fugiat suscipit. Ab ad id facilis culpa.	5	1	1	2024-05-29 20:19:54.173124	2024-05-29 20:19:54.173124
7	Architecto consectetur corrupti quas quasi minus ducimus modi. Ipsam ducimus voluptas accusantium cupiditate. Eum nesciunt odit reprehenderit distinctio at.	17	1	1	2024-05-29 20:19:54.174596	2024-05-29 20:19:54.174596
8	Dolores eius nostrum repudiandae asperiores dolorum dolorem. Necessitatibus animi voluptate eaque tempora.	4	1	1	2024-05-29 20:19:54.176253	2024-05-29 20:19:54.176253
9	Possimus totam officia dolorum labore. Officiis quis ex soluta temporibus. Illo dolore cum rem dolores. Eos tempora occaecati fuga numquam aliquam.	3	1	1	2024-05-29 20:19:54.177322	2024-05-29 20:19:54.177322
10	Consequatur sunt explicabo cum aut esse culpa temporibus. Ratione similique corporis eaque repellat praesentium. Ad vero optio porro excepturi ea consequuntur.	3	1	1	2024-05-29 20:19:54.178317	2024-05-29 20:19:54.178317
11	Nemo occaecati vitae a. Quos temporibus cumque fuga facere.	11	1	1	2024-05-29 20:19:54.179439	2024-05-29 20:19:54.179439
12	Minima enim sed hic vitae modi praesentium ipsum magnam. Debitis dignissimos aspernatur eius dolore recusandae. Quidem accusamus porro eligendi hic ullam. Rem aspernatur sunt nam quaerat placeat.	13	1	1	2024-05-29 20:19:54.180688	2024-05-29 20:19:54.180688
13	Possimus cumque officiis iusto distinctio soluta error nam. Quas iure rerum nobis expedita. Voluptatibus ducimus itaque quia iusto sit. Deleniti alias adipisci deserunt.	37	1	1	2024-05-29 20:19:54.181988	2024-05-29 20:19:54.181988
14	Hic quisquam voluptate qui aut iusto eos. Eaque neque aut delectus laborum. Vel laboriosam ab minus beatae.	14	1	1	2024-05-29 20:19:54.18365	2024-05-29 20:19:54.18365
15	Quisquam pariatur sit rerum asperiores in ab magnam. Cumque illum sunt non blanditiis laboriosam nesciunt ad. At modi quod ad corrupti. Quas ratione earum earum dolorum.	11	1	1	2024-05-29 20:19:54.185236	2024-05-29 20:19:54.185236
16	Rerum autem reiciendis veritatis quam perferendis facere. Sit recusandae assumenda excepturi modi quisquam.	7	1	1	2024-05-29 20:19:54.186614	2024-05-29 20:19:54.186614
17	Nostrum est modi dolorem ratione quibusdam nesciunt. Corporis inventore sequi architecto natus. Deleniti quidem dolor eius quis. Magni quas dignissimos sed quas.	29	1	1	2024-05-29 20:19:54.188068	2024-05-29 20:19:54.188068
18	Cumque quod explicabo aliquam voluptates pariatur. Ipsa a molestiae alias deserunt adipisci doloremque nam. Dolore exercitationem voluptate commodi repellendus.	4	1	1	2024-05-29 20:19:54.189472	2024-05-29 20:19:54.189472
19	Iste repellendus in eius. Provident blanditiis sequi corrupti quis. Est repellendus vero ex non harum harum nulla.	5	1	1	2024-05-29 20:19:54.190468	2024-05-29 20:19:54.190468
20	Facere accusamus similique illum dicta unde. Numquam deserunt illum ratione amet tenetur similique laboriosam. Accusamus architecto incidunt praesentium cumque odit alias.	10	1	1	2024-05-29 20:19:54.191784	2024-05-29 20:19:54.191784
21	Sapiente neque ipsum sunt officiis. Nam sed deserunt facere quae. Esse optio veniam sit eaque.	20	1	1	2024-05-29 20:19:54.192814	2024-05-29 20:19:54.192814
22	Magnam autem sint error fugiat. Vel ea perspiciatis dolore pariatur cupiditate. Cumque earum nihil iste vitae labore. Repudiandae consectetur quam consequatur quasi.	7	1	1	2024-05-29 20:19:54.19392	2024-05-29 20:19:54.19392
23	Enim atque temporibus nobis accusantium cupiditate voluptatibus dicta. Quos aspernatur enim quo ut. Magni aliquam ipsam dolores quis numquam. Ipsa suscipit quisquam rem iusto sit natus suscipit hic.	23	1	1	2024-05-29 20:19:54.195325	2024-05-29 20:19:54.195325
24	Veritatis eaque atque dicta esse alias ex. Aperiam nihil mollitia non et exercitationem explicabo. Consectetur molestiae perspiciatis nisi atque.	28	1	1	2024-05-29 20:19:54.196564	2024-05-29 20:19:54.196564
25	Rerum ipsum aut possimus eos quaerat explicabo esse. Iure rerum quos perferendis praesentium. Consectetur repellendus porro temporibus eveniet omnis laborum nobis.	3	1	1	2024-05-29 20:19:54.197686	2024-05-29 20:19:54.197686
26	Esse beatae veniam id quam. Autem odit doloribus nemo at maxime illo laborum. Non tenetur ut animi fugiat. Reprehenderit omnis ratione officiis nihil nostrum facilis architecto.	32	1	1	2024-05-29 20:19:54.198649	2024-05-29 20:19:54.198649
27	Cum dicta reiciendis ullam necessitatibus nihil. Nobis ducimus dolorum doloribus ipsum. Pariatur nesciunt similique voluptatum soluta.	12	1	1	2024-05-29 20:19:54.199989	2024-05-29 20:19:54.199989
28	Non et ex reiciendis voluptatum. Qui autem fugiat odio dolorum sed explicabo. Officiis quibusdam perferendis rem quibusdam necessitatibus.	15	1	1	2024-05-29 20:19:54.201236	2024-05-29 20:19:54.201236
29	Vel inventore eos harum delectus. Cupiditate repudiandae suscipit deserunt facilis aliquid est.	22	1	1	2024-05-29 20:19:54.202142	2024-05-29 20:19:54.202142
30	Voluptas suscipit ex a magnam delectus. In hic consectetur ratione. Minima vero nobis molestiae dolorem. Qui at sed magni ea ad.	9	1	1	2024-05-29 20:19:54.203078	2024-05-29 20:19:54.203078
31	Similique est labore molestiae sunt. Iste a nisi accusantium debitis. Velit eligendi placeat modi aspernatur eius saepe. Alias animi eius delectus ut.	36	1	1	2024-05-29 20:19:54.204133	2024-05-29 20:19:54.204133
32	Ea ipsam quod saepe labore dolorum beatae. Nam ipsum nobis quia itaque possimus. Doloribus saepe consequatur alias non. Numquam occaecati corrupti harum quam esse illum.	26	1	1	2024-05-29 20:19:54.205067	2024-05-29 20:19:54.205067
33	Saepe quasi iusto mollitia officia. Quibusdam doloribus cum quod explicabo voluptates temporibus aut. Dolorem iusto minus necessitatibus est laudantium. Libero vero est voluptates occaecati commodi.	19	1	1	2024-05-29 20:19:54.206062	2024-05-29 20:19:54.206062
34	Maiores iste saepe modi sint nesciunt deleniti eveniet. Porro in id aperiam quo aperiam eligendi voluptates nisi. Fugiat fuga voluptatibus minima libero odio libero expedita non.	4	1	1	2024-05-29 20:19:54.20704	2024-05-29 20:19:54.20704
35	Neque dicta dolorem itaque animi earum repellat libero. Doloribus cum architecto ab dolore quia.	30	1	1	2024-05-29 20:19:54.207911	2024-05-29 20:19:54.207911
36	Itaque expedita fuga impedit. Ullam accusamus molestiae dolor enim. Non eveniet earum quia eum quidem natus.	5	1	1	2024-05-29 20:19:54.210515	2024-05-29 20:19:54.210515
37	Ipsum vel asperiores rem repellendus occaecati beatae vel. Dolores rem atque voluptate iusto ipsa. Eos repellat minima provident quas ad. Vero numquam minima omnis ea suscipit.	30	1	1	2024-05-29 20:19:54.21221	2024-05-29 20:19:54.21221
38	Illum iusto voluptate eius nostrum. Ad quis tenetur expedita quod. Nam nihil repellat eum rem repellendus voluptates.	3	1	1	2024-05-29 20:19:54.213351	2024-05-29 20:19:54.213351
39	Eos quis atque ratione. Nobis pariatur in possimus voluptates explicabo delectus. Temporibus quo amet doloribus iure amet nisi adipisci. Perspiciatis odio hic atque aspernatur id provident.	8	1	1	2024-05-29 20:19:54.214395	2024-05-29 20:19:54.214395
40	Placeat quaerat eligendi cumque occaecati beatae iste. Impedit rerum tempore incidunt nam animi occaecati quam. Repudiandae perspiciatis quo vero corporis.	20	1	1	2024-05-29 20:19:54.216588	2024-05-29 20:19:54.216588
41	Vero dolorem fugiat optio esse. Deleniti recusandae fugit autem fugit enim officia maiores.	29	1	1	2024-05-29 20:19:54.217726	2024-05-29 20:19:54.217726
42	Quae nisi laboriosam quod. Iste deleniti consectetur pariatur illum laborum quasi. Dolor alias dicta dolores voluptatem voluptate rem.	18	1	1	2024-05-29 20:19:54.219131	2024-05-29 20:19:54.219131
43	Nesciunt consequuntur dolorem maxime ducimus excepturi id odit quae. Cupiditate maiores vero commodi. Error hic libero hic tempora. Eligendi voluptatibus illo voluptate delectus est.	3	1	1	2024-05-29 20:19:54.220261	2024-05-29 20:19:54.220261
44	Aut natus tempora debitis minus. Cumque doloremque nihil doloremque dolor dolor fugiat quisquam praesentium. Quis in dolorum numquam nemo quam.	22	1	1	2024-05-29 20:19:54.221678	2024-05-29 20:19:54.221678
45	Sapiente nesciunt voluptate magni doloremque facere minus. Rerum impedit nobis debitis facere nihil beatae nostrum. Explicabo quas totam voluptas quo voluptatum ipsam.	24	1	1	2024-05-29 20:19:54.223806	2024-05-29 20:19:54.223806
46	Aliquid porro assumenda beatae magnam minima sit. Debitis deleniti quos dolorum iure. Ipsam in distinctio ipsum impedit eum debitis sapiente.	34	1	1	2024-05-29 20:19:54.225017	2024-05-29 20:19:54.225017
47	Dolore perferendis aspernatur assumenda iste. Similique ullam ipsa culpa repudiandae accusamus quisquam temporibus aut. Minus beatae impedit exercitationem necessitatibus doloribus hic quis.	34	1	1	2024-05-29 20:19:54.22616	2024-05-29 20:19:54.22616
48	Voluptatum sunt molestias amet ipsam minima. Repellendus in sit voluptas. Aperiam illum non recusandae quibusdam deleniti aperiam.	27	1	1	2024-05-29 20:19:54.227227	2024-05-29 20:19:54.227227
49	Dolore blanditiis quae molestiae exercitationem. Cum esse provident officia quae dignissimos nemo. Ipsam libero nobis molestias hic omnis ratione. Deleniti porro aliquid maiores excepturi facere cum.	15	1	1	2024-05-29 20:19:54.228611	2024-05-29 20:19:54.228611
50	Quae vitae qui reiciendis dicta nisi velit dolore quod. Dignissimos aliquam facere error cumque hic quod voluptate neque. Enim explicabo eligendi corrupti.	14	1	1	2024-05-29 20:19:54.229897	2024-05-29 20:19:54.229897
51	Et amet voluptatibus blanditiis. Ipsa consectetur porro eos. Earum quaerat corporis iure. Nobis ut optio beatae.	7	1	1	2024-05-29 20:19:54.231558	2024-05-29 20:19:54.231558
52	Tempore quam consectetur ipsa iusto soluta. Veniam accusantium debitis veniam magnam quis rerum. Quo earum dolorem eius facere labore accusantium. Cupiditate aliquid nulla ad eaque maxime aut.	14	1	1	2024-05-29 20:19:54.233301	2024-05-29 20:19:54.233301
53	Facilis dolores id laborum facilis sapiente quod natus. Laboriosam libero modi quas nisi. Assumenda quo necessitatibus vero omnis consectetur praesentium.	26	1	1	2024-05-29 20:19:54.235085	2024-05-29 20:19:54.235085
54	Aperiam repellendus excepturi ab necessitatibus inventore ipsa. Aperiam iusto fugiat voluptates autem consectetur pariatur. Omnis eos repellendus sint dolorum. Laudantium neque tempore sint non.	12	1	1	2024-05-29 20:19:54.236511	2024-05-29 20:19:54.236511
55	Numquam illum suscipit provident. Accusantium natus exercitationem fugiat deleniti porro quaerat. Dignissimos laboriosam et illo delectus.	19	1	1	2024-05-29 20:19:54.23758	2024-05-29 20:19:54.23758
56	Tempore fuga dignissimos molestiae accusantium fuga nisi minus. Nulla atque natus voluptatem dolor omnis ullam officia. Molestias expedita dolore provident.	36	1	1	2024-05-29 20:19:54.238699	2024-05-29 20:19:54.238699
57	Blanditiis blanditiis consequuntur reprehenderit assumenda distinctio. Eos eius magni omnis. Quisquam beatae molestias dolor at. Vitae labore dolorum magnam excepturi numquam ex.	6	1	1	2024-05-29 20:19:54.239968	2024-05-29 20:19:54.239968
58	Quod vero aut distinctio iste doloremque inventore. Ut blanditiis doloribus illum animi. Adipisci quas quisquam odit eum a exercitationem. Dolorem consequuntur qui architecto nobis at earum.	18	1	1	2024-05-29 20:19:54.241787	2024-05-29 20:19:54.241787
59	Sapiente quis possimus numquam nobis magnam rem architecto nesciunt. Accusantium est porro fugiat accusamus necessitatibus dignissimos. Magni eligendi atque maiores quae odio.	37	1	1	2024-05-29 20:19:54.24419	2024-05-29 20:19:54.24419
60	Blanditiis fuga blanditiis aut fugit fuga ullam odit. Accusantium consectetur excepturi architecto quos voluptatibus. In quam fugit ratione laudantium ratione perspiciatis at.	10	1	1	2024-05-29 20:19:54.245768	2024-05-29 20:19:54.245768
61	Quod nihil dolore nihil aspernatur vitae eum nihil. Quia neque assumenda temporibus nihil et officia. Molestias eveniet quibusdam magnam nisi et ex. Incidunt nobis nemo temporibus facere fugit.	8	1	1	2024-05-29 20:19:54.247552	2024-05-29 20:19:54.247552
62	Eveniet delectus eligendi itaque. Laborum laborum accusamus rerum dolore odio quidem soluta. Excepturi autem similique voluptate labore excepturi.	16	1	1	2024-05-29 20:19:54.249619	2024-05-29 20:19:54.249619
63	Minima fugiat sequi esse dignissimos culpa fuga. Quae veniam at unde. Ullam quae repellat temporibus modi ut.	9	1	1	2024-05-29 20:19:54.25136	2024-05-29 20:19:54.25136
64	Porro aliquam doloremque quidem temporibus vero. Culpa laborum pariatur adipisci commodi provident sed maiores. Voluptas earum officiis excepturi delectus placeat officiis dicta cupiditate.	18	1	1	2024-05-29 20:19:54.25266	2024-05-29 20:19:54.25266
65	Pariatur dolorem saepe impedit fugit. Quis molestiae dicta magni alias. Quia hic dolorum veritatis dignissimos voluptates quisquam incidunt.	4	1	1	2024-05-29 20:19:54.253979	2024-05-29 20:19:54.253979
66	Ipsum itaque neque qui fugiat assumenda aliquid minima. Hic a dolorum inventore quisquam qui vel. Voluptatem maiores ratione cumque ipsum non. Quo id corrupti ipsam accusamus reiciendis ducimus nemo.	5	1	1	2024-05-29 20:19:54.255308	2024-05-29 20:19:54.255308
67	Repellendus quasi laborum quae voluptate architecto. In ullam pariatur magni nulla dolores reprehenderit officia deserunt. Autem culpa quia dolor debitis. Est iste at assumenda iusto possimus.	35	1	1	2024-05-29 20:19:54.257857	2024-05-29 20:19:54.257857
68	Ab reprehenderit commodi quod cupiditate dignissimos quis dolorum. Quidem ratione a praesentium quos asperiores. Doloribus odio voluptatum magni sit. Et excepturi magni eveniet.	8	1	1	2024-05-29 20:19:54.259493	2024-05-29 20:19:54.259493
69	Iusto nemo voluptates corporis nostrum est provident totam quae. Sequi eaque commodi distinctio earum odio eos labore. Illo porro incidunt voluptas laudantium.	33	1	1	2024-05-29 20:19:54.261058	2024-05-29 20:19:54.261058
70	Magnam vitae omnis at quibusdam et quasi. Rem voluptates porro aut animi numquam. Voluptatum ipsum provident reprehenderit et suscipit fuga eaque.	17	1	1	2024-05-29 20:19:54.262889	2024-05-29 20:19:54.262889
71	Exercitationem laboriosam quos reprehenderit dolorem dolor beatae veritatis a. Sed nesciunt dolorum et minima fuga repudiandae ratione. Quod dignissimos quam dignissimos consequatur eum.	22	1	1	2024-05-29 20:19:54.264617	2024-05-29 20:19:54.264617
72	Rem cumque assumenda reiciendis aliquam explicabo. Nulla dolore repellat corrupti debitis nostrum. Aut alias expedita iure provident quae. Culpa vel corporis totam vel dolore velit.	37	1	1	2024-05-29 20:19:54.265827	2024-05-29 20:19:54.265827
73	Vitae ut delectus vel reiciendis sit animi. Animi itaque veritatis sunt. Ex odit quod sed error commodi quae consequuntur. Aliquid saepe velit occaecati ducimus tempore sapiente veritatis.	20	1	1	2024-05-29 20:19:54.267246	2024-05-29 20:19:54.267246
74	Magnam id voluptatibus reprehenderit corporis. Incidunt saepe cupiditate nostrum adipisci.	30	1	1	2024-05-29 20:19:54.268236	2024-05-29 20:19:54.268236
75	Nisi nobis vel nihil. Debitis error eaque eos officia magnam quidem architecto doloribus. Iusto asperiores ullam vero ex voluptate inventore.	35	1	1	2024-05-29 20:19:54.269382	2024-05-29 20:19:54.269382
76	Quos quisquam illum harum voluptatem doloribus. Dolorem debitis in dolores. Eveniet ad voluptates vitae maxime.	6	1	1	2024-05-29 20:19:54.270361	2024-05-29 20:19:54.270361
77	Quidem iste fugit perferendis ipsa provident. Debitis quisquam deserunt accusantium tempore ducimus. Fugit delectus voluptatem ut doloremque.	13	1	1	2024-05-29 20:19:54.271723	2024-05-29 20:19:54.271723
78	Laudantium in provident quam sunt exercitationem unde ipsa similique. Repellat corrupti quibusdam omnis cumque mollitia pariatur eius incidunt. Vero aut et fugiat dolores.	25	1	1	2024-05-29 20:19:54.273333	2024-05-29 20:19:54.273333
79	Magni quibusdam facere repellat unde nihil cupiditate. Quos nostrum corporis ad laudantium officia architecto. Accusamus adipisci minima architecto odio sit deleniti.	30	1	1	2024-05-29 20:19:54.275062	2024-05-29 20:19:54.275062
80	Aliquam quos ipsam ipsam eos molestias cupiditate. Quam corporis iusto id. Iusto molestias mollitia nemo dolorum a atque assumenda.	14	1	1	2024-05-29 20:19:54.276621	2024-05-29 20:19:54.276621
81	Quia in similique consequuntur deleniti laudantium odio dolor. Assumenda amet hic nulla fuga asperiores. Totam cum eius totam. Rerum ratione eligendi natus quasi dicta est dolorum repellendus.	31	1	1	2024-05-29 20:19:54.277887	2024-05-29 20:19:54.277887
82	Accusantium a voluptatem eius. Ipsa dolores tenetur ad sed optio. Iure hic cupiditate id blanditiis expedita dolore consequuntur.	6	1	1	2024-05-29 20:19:54.279185	2024-05-29 20:19:54.279185
83	Sunt eaque qui dolores autem. Ut officiis tempora cupiditate accusantium libero veritatis optio. Sunt voluptatibus iusto earum optio necessitatibus.	14	1	1	2024-05-29 20:19:54.28024	2024-05-29 20:19:54.28024
84	Sunt non nemo totam voluptate. Quis aliquid maiores nisi. Ea error deserunt commodi veritatis eum libero delectus. Repellendus quam maiores voluptatum omnis voluptatibus reprehenderit possimus.	7	1	1	2024-05-29 20:19:54.281856	2024-05-29 20:19:54.281856
85	Accusantium voluptates maxime qui maiores non repudiandae. Corporis soluta vero tempore. Quas temporibus cupiditate voluptatem provident assumenda officiis.	34	1	1	2024-05-29 20:19:54.283238	2024-05-29 20:19:54.283238
86	Eveniet eius itaque sit dolores. Cumque voluptatibus animi velit fuga veritatis. Officia laborum dicta itaque. Libero accusamus quia mollitia numquam iure.	30	1	1	2024-05-29 20:19:54.284362	2024-05-29 20:19:54.284362
87	Libero consequatur voluptate quisquam magnam magnam. Labore laborum quisquam laudantium rerum unde dolores eligendi. Porro architecto occaecati asperiores quam.	12	1	1	2024-05-29 20:19:54.285613	2024-05-29 20:19:54.285613
88	Libero libero dolor ut natus. Nisi voluptas quidem ipsa nisi qui reiciendis. Facilis nobis dolor nobis assumenda.	13	1	1	2024-05-29 20:19:54.287002	2024-05-29 20:19:54.287002
89	Esse repellat temporibus commodi alias. Adipisci fugiat dolorum nobis dolor quam facere consequatur. Nam aspernatur quaerat illo.	7	1	1	2024-05-29 20:19:54.288708	2024-05-29 20:19:54.288708
90	Atque mollitia doloribus nesciunt. Dignissimos officia veritatis praesentium quibusdam. Ea perspiciatis impedit occaecati soluta.	23	1	1	2024-05-29 20:19:54.290089	2024-05-29 20:19:54.290089
91	Laborum aperiam repellat officiis itaque quibusdam cumque. Fuga ipsam ex at fugiat minus rerum fuga. Quo esse aliquam unde ipsam.	7	1	1	2024-05-29 20:19:54.291184	2024-05-29 20:19:54.291184
92	Suscipit consectetur nihil tempore nihil quam possimus sunt itaque. Facilis minima eum sequi temporibus enim.	28	1	1	2024-05-29 20:19:54.295993	2024-05-29 20:19:54.295993
93	A cumque eos corporis dolorum est maiores atque. Delectus voluptas laudantium odio laborum incidunt itaque delectus veniam. Qui asperiores perferendis iusto nemo excepturi.	12	1	1	2024-05-29 20:19:54.298252	2024-05-29 20:19:54.298252
94	Aliquid eveniet amet pariatur dignissimos corporis quos. Possimus id sit enim. Nulla exercitationem molestias quia natus delectus.	6	1	1	2024-05-29 20:19:54.29949	2024-05-29 20:19:54.29949
95	Blanditiis in incidunt pariatur harum officiis. At accusantium odit vitae excepturi ducimus perferendis eos minima.	33	1	1	2024-05-29 20:19:54.300766	2024-05-29 20:19:54.300766
96	Voluptas dicta atque nemo eveniet. Eum iusto impedit numquam aut. Magni eligendi provident quaerat mollitia vel.	30	1	1	2024-05-29 20:19:54.302074	2024-05-29 20:19:54.302074
97	Voluptates cumque error veritatis cum facilis. Dicta omnis laboriosam earum cum tenetur. Provident quae cum id ipsa magni quos. Occaecati reprehenderit quia maiores illum omnis in est ab.	5	1	1	2024-05-29 20:19:54.303266	2024-05-29 20:19:54.303266
98	Inventore consequuntur eaque error porro. Ab reiciendis exercitationem neque. Laudantium culpa ad veniam exercitationem.	30	1	1	2024-05-29 20:19:54.304252	2024-05-29 20:19:54.304252
99	Similique quo tempora molestias assumenda culpa autem ut. Cumque optio ducimus commodi sit iure similique dolorum. Dicta perspiciatis dignissimos omnis. Laudantium eius vero iusto reprehenderit.	10	1	1	2024-05-29 20:19:54.305418	2024-05-29 20:19:54.305418
100	Non nemo aliquam suscipit non. Expedita sapiente necessitatibus temporibus fugiat. Minus fuga unde corporis.	31	1	1	2024-05-29 20:19:54.306742	2024-05-29 20:19:54.306742
102	Nulla enim ad distinctio ducimus ullam magni. Cupiditate facilis ab eaque occaecati. Totam quas eaque ipsam dolorum tempora. Magni quia explicabo animi est.	28	50	1	2024-05-29 20:25:45.708289	2024-05-29 20:25:45.708289
5	hello	10	1	2	2024-05-29 20:19:54.171874	2024-05-30 17:26:16.301452
\.


                                                                                                                                                                                                                                                                                                                                                                      3354.dat                                                                                            0000600 0004000 0002000 00000000030 14626117060 0014244 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	manager
2	client
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        3356.dat                                                                                            0000600 0004000 0002000 00000000113 14626117060 0014250 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	new
2	process
3	complete
4	canceled
5	on hold
6	waiting for payment
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                     3358.dat                                                                                            0000600 0004000 0002000 00000014132 14626117060 0014260 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Brandon	Faulkner	05168338757	740 Cobb Mills\nLake Barbara, SD 81890-6009	joshuahill@clark.biz	2	N46F_Mk&(1	xfarley
2	John	Lane	598-180-2381	2484 Regina Brooks Suite 193\nNew Kaitlyn, MT 67430-8840	lpearson@yahoo.com	2	mcx6Xjt9(9	troy77
3	Tina	Gardner	+39(8)5697140242	4897 Jennings Springs\nAmberport, MO 02162-4604	kristinetran@gmail.com	2	^6zCGqqvdZ	andreahodges
4	Nathaniel	Woodward	(527)172-4938	35156 Hanson Loaf Suite 718\nChristopherside, VA 78634-9623	eturner@hotmail.com	2	&9XHSJhS93	wheelertammy
5	Kristin	Ramirez	813.566.6366x77145	265 Jackson Prairie\nPort Donaldport, AS 74731	jordanwatson@yahoo.com	2	&T3qeVxY@U	dramirez
6	Jessica	White	1-175-525-5600x389	84591 Shaw Skyway Suite 494\nRobertshire, MI 75400-2440	charles08@jackson.com	2	U&sVY4wv$M	williamsharold
7	Rick	Meadows	1-328-852-6341x222	04680 Daniels Camp\nCrawfordhaven, LA 72033	scott38@gmail.com	2	!MJ$1Qj36z	sarahadkins
8	Carly	Crosby	(280)765-6016	686 Olivia Trafficway Suite 894\nEspinozafurt, DC 33388	wlopez@gmail.com	2	$oJi5kZ7O4	ndavis
9	Cathy	Garcia	+69(1)4758952009	5509 Diaz Mountains\nNew Jenniferville, HI 46060-2454	meganellis@yahoo.com	2	(98xJJJk#V	harrissuzanne
10	Jose	Gross	670-745-4368	4528 Joshua Gardens\nEast Stephanie, NY 58363	grimesbrandon@yahoo.com	2	k+7B*Qntz3	efrancis
11	Christy	Kelley	171.959.3080	7649 Ashley Groves\nNorth Ronald, ND 67436	zachary13@yahoo.com	2	_QKsZ+hEc3	thomashood
12	Tiffany	Fischer	02804617341	260 Young Trace Apt. 044\nPort Dale, MS 84477-4887	james83@gmail.com	2	)rpNHc761a	cowanjessica
13	Patrick	Lewis	(876)901-2852x779	78534 Matthew Haven\nEast Davidville, NM 31105-5864	schmidtnatalie@cameron.info	2	IV6ZKP6cN_	fli
14	Diane	Rodriguez	099-308-4969x9236	93440 Eileen Inlet\nWest Julieville, FL 77243	clarkmelissa@knapp.info	2	#aZHdOvi1*	floresamy
15	Reginald	Bentley	1-773-169-8823x801	0237 Brown Orchard Apt. 094\nLake Markfurt, MO 68316-4999	matthewwebb@hotmail.com	2	$)FI1Cq(i9	dominiquehudson
16	Denise	Casey	295.483.7368x050	USNS Johnson\nFPO AA 65664-5993	urice@davidson.com	2	&7MQ99knD#	ashley31
17	Ian	Brown	08611961784	PSC 9894, Box 1198\nAPO AA 28116-7272	crhodes@ellison.com	2	nc7Eqv2s^8	bschmidt
18	Jorge	Gallagher	311.646.3558	3621 Deleon Spring\nWattsview, OR 05238-6163	josephhuber@knight.info	2	K8UyCBtk&(	hgardner
19	Troy	Cox	1-111-069-9227x78428	9111 Peter Lights Apt. 101\nSouth Nicoleshire, TX 60796-0604	stantonjudy@gmail.com	2	q#9c7pkE+R	christophercampbell
20	Ricky	Robinson	510-661-6941x91006	PSC 7596, Box 3887\nAPO AP 77262	royjane@bowen.com	2	ul0rpHNIA$	aharris
21	Rachel	Daugherty	07644883999	60630 Nguyen Roads\nMeltonmouth, NE 29391-3918	jmills@ortiz.org	2	V#i8YYg6oX	larry98
22	Erica	Allen	990-952-2974	933 Rodriguez Circle Apt. 007\nCarolineborough, MH 98159-3403	gutierrezjose@hotmail.com	2	6x4GhER_j+	kmurphy
23	Troy	Barker	(149)460-8656x11344	98583 Jason Ways Apt. 662\nMillershire, IA 66143-1097	jasonsandoval@gmail.com	2	$9lvG$BrB@	dennisbrandy
24	Angela	Brown	104-202-8734	8409 Paul Wells\nPatrickside, MA 37357	emily61@robinson.com	2	cQCQ8Dqf&w	jamie00
25	John	Terry	1-808-819-3251	56903 Christensen Court Suite 827\nKellyshire, MA 11771-3773	ronaldmcdonald@gmail.com	2	%s7^Lang#!	elizabeth31
26	David	Leonard	194-878-8210x771	24672 Harris Motorway\nKevinburgh, DE 76894-6014	adam35@yahoo.com	2	#nzKA(eeq2	graybethany
27	Hailey	Johnson	05789674244	Unit 0428 Box 5022\nDPO AE 64468	tallen@hotmail.com	2	_RqIu#MrT3	brianna97
28	Antonio	Johnson	1-052-288-4964	3267 Wise Ranch\nPort Courtney, AL 32729	traceyhampton@gmail.com	2	Dp44)Szn)a	tamaramckinney
29	Daniel	Schneider	1-260-357-3664	095 Amber Glen\nNorth Rita, PW 97341	garrettkeith@gmail.com	2	M(MIu8AunG	reyesjacob
30	Pamela	Kemp	1-523-169-2809x81592	049 Timothy Plains Suite 832\nPort Thomaston, MD 22260	markjohnson@yahoo.com	2	X(8NcBVY_&	gaguirre
31	Alexis	White	256-057-8955x4180	79890 Waters Turnpike\nWest Lauren, IL 37533-7895	rogercuevas@todd-palmer.info	2	@yF$7G8e4e	brooksaaron
32	Andrea	White	+29(6)9765956832	16316 Courtney Via\nSilvaville, AZ 69208-3658	karen97@singleton.net	2	2fDucJv^#l	rhonda06
33	Amber	Sanchez	+17(1)9746854257	USS Jackson\nFPO AE 93808-5089	vholt@holmes.com	2	)#MJ@uEe)2	ssanford
34	Mary	Tucker	1-007-165-6039x9610	905 Angelica Bypass\nEast Isaac, KS 39687	susanhines@gmail.com	2	@L(WP+q+N3	leahlopez
35	Bernard	Martin	(559)826-7615	4864 Montoya Coves\nJasmineton, PA 25186-9733	elliottmolly@hotmail.com	2	@g#5zYh#Sd	jordancarla
36	Dawn	Lee	(025)710-1642	Unit 5930 Box 9299\nDPO AE 67930-6634	sara60@gmail.com	2	d&XSV9&fvI	briana10
37	Michael	Ray	369-469-2035	52016 Gomez Trafficway\nNew Sean, LA 35343	hlindsey@cherry-davidson.com	2	+%189AuvmB	villarrealrenee
38	Maria	Smith	771.969.4661x34530	9952 Butler Cliff\nLake Richard, MN 31026	aprillynch@yahoo.com	2	$*3uVk@oE(	johnfritz
39	Deanna	Williams	1-654-926-2293x6260	USNS Stafford\nFPO AP 57784	heathergarcia@gmail.com	2	(1uNxjOfsX	barrybrittney
40	Eric	Vega	072-573-7130	2006 Steele Station Suite 526\nAllenfurt, IN 85863	nicholasjensen@gmail.com	2	HQKM@kDf+1	jamessmith
41	Duane	Klein	(191)914-5317	152 Johnson Way\nEast Michaelton, FL 63987	uwhite@michael.com	2	4zezOvM4##	jessica37
42	Kevin	Gregory	+34(6)1995391215	194 Michael Radial\nNorth Phillip, FM 25186	morgandanielle@yahoo.com	2	gx041PKwV$	millerfrank
43	Austin	Novak	(812)093-4818x37758	0431 Jenkins Falls\nLake Michelle, FM 25059-5302	pdeleon@yahoo.com	2	*!1h^)srTO	norrislaura
44	Ryan	Evans	(335)432-8996	07069 Michelle Keys\nThompsonfurt, UT 83336-6153	tmoore@hotmail.com	2	34%FYlNs_o	pporter
45	Todd	Russell	02077786083	4735 Lindsey River\nMichaeltown, HI 93352-2025	rogersbeverly@mcbride-klein.com	2	xTmIgpWe&7	daltonmargaret
46	Martha	Perez	05097130095	34848 Tracy Lake\nKemphaven, FM 03247-0515	carlos13@le.com	2	v$X70Fibn(	lauren46
47	Gregory	Diaz	1-835-687-8238x9344	483 Jon Ridges Apt. 661\nLake Johnnyhaven, VI 34706	humphreymelissa@nolan.com	2	6FI1OnFM&G	washingtonanthony
48	Andrew	Garcia	630-350-6707	926 Nicole Extension\nNicholasfort, PR 02528-9576	eric34@hotmail.com	2	N$8Bg4d6!9	robertyoung
49	Kevin	Reynolds	830-301-9605x0541	142 Roy Plains\nNicholasport, KS 23884	allensarah@burton.org	2	n2V7xntv%Z	kevindiaz
50	Adam	Hall	847.095.5067	4228 Brandy Common Suite 411\nDavidberg, AK 65957	brittany99@king-myers.org	2	yn7$QYLS7@	aaron38
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                      restore.sql                                                                                         0000600 0004000 0002000 00000026404 14626117060 0015375 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        --
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 14.5
-- Dumped by pg_dump version 14.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE "CRM";
--
-- Name: CRM; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "CRM" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1252';


ALTER DATABASE "CRM" OWNER TO postgres;

\connect "CRM"

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: generate_user_data(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.generate_user_data() RETURNS TABLE(name character varying, last_name character varying, phone character varying, address character varying, email character varying, role_id integer, password character varying, user_name character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY
    SELECT
      faker.name.find_name() AS name,
      faker.name.last_name() AS last_name,
      faker.phone.phone_number() AS phone,
      faker.address.street_address() || ', ' || faker.address.city() || ', ' || faker.address.country_code() AS address,
      faker.internet.email() AS email,
      FLOOR(RANDOM(2) * (SELECT MAX(id) FROM roles)) + 1 AS role_id,
	faker.phone.phone_number() AS password,
      faker.internet.user_name() AS user_name;
END;
$$;


ALTER FUNCTION public.generate_user_data() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: comments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comments (
    id integer NOT NULL,
    deal_id integer NOT NULL,
    user_id integer NOT NULL,
    comment text NOT NULL,
    create_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.comments OWNER TO postgres;

--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comments_id_seq OWNER TO postgres;

--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- Name: deals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deals (
    id integer NOT NULL,
    deal_dscription text,
    client_id integer,
    manager_id integer NOT NULL,
    status_id integer DEFAULT 1 NOT NULL,
    create_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.deals OWNER TO postgres;

--
-- Name: deals_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.deals_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.deals_id_seq OWNER TO postgres;

--
-- Name: deals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.deals_id_seq OWNED BY public.deals.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    role_name character varying(50) NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_id_seq OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.status (
    id integer NOT NULL,
    status_name character varying(50) NOT NULL
);


ALTER TABLE public.status OWNER TO postgres;

--
-- Name: status_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.status_id_seq OWNER TO postgres;

--
-- Name: status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.status_id_seq OWNED BY public.status.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    phone character varying(20),
    address character varying(255),
    email character varying(320) NOT NULL,
    role_id integer NOT NULL,
    password character varying(255) NOT NULL,
    user_name character varying(255) NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- Name: deals id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deals ALTER COLUMN id SET DEFAULT nextval('public.deals_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: status id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status ALTER COLUMN id SET DEFAULT nextval('public.status_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comments (id, deal_id, user_id, comment, create_date) FROM stdin;
\.
COPY public.comments (id, deal_id, user_id, comment, create_date) FROM '$$PATH$$/3362.dat';

--
-- Data for Name: deals; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.deals (id, deal_dscription, client_id, manager_id, status_id, create_date, update_date) FROM stdin;
\.
COPY public.deals (id, deal_dscription, client_id, manager_id, status_id, create_date, update_date) FROM '$$PATH$$/3360.dat';

--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, role_name) FROM stdin;
\.
COPY public.roles (id, role_name) FROM '$$PATH$$/3354.dat';

--
-- Data for Name: status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.status (id, status_name) FROM stdin;
\.
COPY public.status (id, status_name) FROM '$$PATH$$/3356.dat';

--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, last_name, phone, address, email, role_id, password, user_name) FROM stdin;
\.
COPY public.users (id, name, last_name, phone, address, email, role_id, password, user_name) FROM '$$PATH$$/3358.dat';

--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comments_id_seq', 100, true);


--
-- Name: deals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.deals_id_seq', 103, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 2, true);


--
-- Name: status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.status_id_seq', 6, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 50, true);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: deals deals_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deals
    ADD CONSTRAINT deals_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: status status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status
    ADD CONSTRAINT status_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_user_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_user_name_key UNIQUE (user_name);


--
-- Name: comments comments_deal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_deal_id_fkey FOREIGN KEY (deal_id) REFERENCES public.deals(id) ON DELETE CASCADE;


--
-- Name: comments comments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: deals deals_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deals
    ADD CONSTRAINT deals_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: deals deals_manager_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deals
    ADD CONSTRAINT deals_manager_id_fkey FOREIGN KEY (manager_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: deals deals_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deals
    ADD CONSTRAINT deals_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.status(id);


--
-- Name: users users_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id);


--
-- PostgreSQL database dump complete
--

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            