%let pgm=utl-draw-polygons-around-clusters-of-points-r-convex-hulls;

Draw polygons around clusters of points r convex hulls

see for plot
convex hull graph
http://tinyurl.com/38mfdtnj
https://github.com/rogerjdeangelis/utl-draw-polygons-around-clusters-of-points-r-convex-hulls/blob/main/covexhull.pdf
and
https://www.dropbox.com/s/aaqvg9uxzej1ht2/covexhull.pdf?dl=0

github
http://tinyurl.com/38mfdtnj
https://github.com/rogerjdeangelis/utl-draw-polygons-around-clusters-of-points-r-convex-hulls/blob/main/covexhull.pdf

RELATED REPOS
-------------------------------------------------------------------------------------------------------------
https://github.com/rogerjdeangelis/utl-area-of-intersection-of-arbitrary-polygons-R-AI
https://github.com/rogerjdeangelis/utl-identify-points-inside-overlapping-polygons-R-spacial-package
https://github.com/rogerjdeangelis/utl_convex_hull_polygons_encompassing_a_three_dimensional_scatter_plot
https://github.com/rogerjdeangelis/utl_digitize_data_from_image

/*               _     _
 _ __  _ __ ___ | |__ | | ___ _ __ ___
| `_ \| `__/ _ \| `_ \| |/ _ \ `_ ` _ \
| |_) | | | (_) | |_) | |  __/ | | | | |
| .__/|_|  \___/|_.__/|_|\___|_| |_| |_|
|_|
*/

/**************************************************************************************************************************/
/*                                                                                                                        */
/*                                                                                                                        */
/*                     IUNPUT                                                            OUTPUT                           */
/*                                                                                                                        */
/*                                                                                                                        */
/*       0         25         50            75                            0         25           50             75        */
/*     --+----------+----------+-------------+------                      -+----------+----------+--------------+---+     */
/*     |                                            |                   |                                          |      */
/*     |                                            |                   |                                          |      */
/* 200 +                                            +               200 +                                          +      */
/*     |                                            |                   |                                          |      */
/*     |                                            |                   |                                          |      */
/*     |            *          *                    |                   |          *--------- *                    |      */
/*     |                 *    *                     |                   |         /     *    * \                   |      */
/* 150 +         ** ** *** ***                      +               150 +       ** ** *** ***   \                  +      */
/*     |            ** * ** **  * *                 |                   |       \  ** * ** **  * *                 |      */
/*  Y  |                 *    *        *  *    *    |                Y  |        -------*    *  /   *-----*----*   |      */
/*     |                     *       *  **   *      |                   |                \  *  /   / *  **   *  \  |      */
/*     |                   *   *       * *    *  *  |                   |                 *   *    #---*-*    *  * |      */
/* 100 +       *                                * * |               100 +     *            \ /            \  * * | +      */
/*     |       *                              *   * |                   |    /*             *              *-----* |      */
/*     |     *       *                              |                   |   *  \    *----*                         |      */
/*     |       * * *   * *                          |                   |  /  * *-* | * *                          |      */
/*     |   * *  **   *                              |                   | * *  **---*  /                           |      */
/*  50 +                                            +                50 + |   /     \ /                            +      */
/*     |   *  *       *                             |                   | *--*       *                             |      */
/*     |                                            |                   |                                          |      */
/*     |                                            |                   |                                          |      */
/*     |                                            |                   |                                          |      */
/*   0 +                                            +                 0 +                                          +      */
/*     |                                            |                   |                                          |      */
/*     --+----------+----------+-------------+-------                    -+----------+----------+--------------+---+      */
/*       0         25         50            75                           0         25           50             75         */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/


options validvarname=v7;
libname sd1 "d:/sd1";
data sd1.have;
  input x y @@;
cards4;
4 53 5 63 10 59 9 77 13 49 13 69 12 88 15 75 18 61 19 65 22
74 27 72 28 76 24 58 27 55 28 60 30 52 31 60 32 61 36 72 28
147 32 149 35 153 33 154 38 151 41 150 38 145 38 143 32 143
34 141 44 156 44 149 44 143 46 142 47 149 49 152 50 142 53
144 52 152 55 155 54 124 60 136 63 139 86 132 85 115 85 96
78 94 74 96 97 122 98 116 98 124 99 119 99 128 101 115 108
111 110 111 108 116 111 126 115 117 117 115 70 4
;;;;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/* SD1.HAVE total obs=61                                                                                                  */
/*                                                                                                                        */
/*  Obs     x     y                                                                                                       */
/*                                                                                                                        */
/*    1     4     53                                                                                                      */
/*    2     5     63                                                                                                      */
/*    3    10     59                                                                                                      */
/*    4     9     77                                                                                                      */
/*    5    13     49                                                                                                      */
/*    6    13     69                                                                                                      */
/*    7    12     88                                                                                                      */
/*    8    15     75                                                                                                      */
/*    9    18     61                                                                                                      */
/*   10    19     65                                                                                                      */
/*                                                                                                                        */
/**************************************************************************************************************************/
*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

;

%utl_submit_r64('
library(cluster);
library(haven);
ruspini<-read_sas("d:/sd1/have.sas7bdat");
Rusp_HC = hclust(dist(ruspini));
Cluster4 = cutree(Rusp_HC, 4);
pdf("d:/pdf/covexhull.pdf");
plot(ruspini, pch=20, col=rainbow(4)[Cluster4]);
for(i in 1:4) {
    ConvexHull = chull(ruspini[Cluster4 == i, ]);
    polygon(ruspini[Cluster4 == i, ][ConvexHull,],
        border=rainbow(4)[i], col=rainbow(4, alpha=0.1)[i])
};
');

/**************************************************************************************************************************/
/*                                                                                                                        */
/*                        OUTPUT                                                                                          */
/*                                                                                                                        */
/*                                                                                                                        */
/*         0         25           50             75                                                                       */
/*         -+----------+----------+--------------+---+                                                                    */
/*       |                                          |                                                                     */
/*       |                                          |                                                                     */
/*   200 +                                          +                                                                     */
/*       |                                          |                                                                     */
/*       |                                          |                                                                     */
/*       |          *--------- *                    |                                                                     */
/*       |         /     *    * \                   |                                                                     */
/*   150 +       ** ** *** ***   \                  +                                                                     */
/*       |       \  ** * ** **  * *                 |                                                                     */
/*    Y  |        -------*    *  /   *-----*----*   |                                                                     */
/*       |                \  *  /   / *  **   *  \  |                                                                     */
/*       |                 *   *    #---*-*    *  * |                                                                     */
/*   100 +     *            \ /            \  * * | +                                                                     */
/*       |    /*             *              *-----* |                                                                     */
/*       |   *  \    *----*                         |                                                                     */
/*       |  /  * *-* | * *                          |                                                                     */
/*       | * *  **---*  /                           |                                                                     */
/*    50 + |   /     \ /                            +                                                                     */
/*       | *--*       *                             |                                                                     */
/*       |                                          |                                                                     */
/*       |                                          |                                                                     */
/*       |                                          |                                                                     */
/*     0 +                                          +                                                                     */
/*       |                                          |                                                                     */
/*        -+----------+----------+--------------+---+                                                                     */
/*        0         25           50             75                                                                        */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
