package com.esprit.genus.Retrofit;

import io.reactivex.Observable;
import retrofit2.http.Field;
import retrofit2.http.FormUrlEncoded;
import retrofit2.http.GET;
import retrofit2.http.POST;
import retrofit2.http.PUT;

public interface INodeJS {

    @POST("register")
    @FormUrlEncoded
    Observable<String> registerUser(@Field("email") String email,
                                    @Field("username") String username,
                                    @Field("password") String password);

    @POST("login")
    @FormUrlEncoded
    Observable<String> loginUser(@Field("email") String email,
                                    @Field("password") String password);



    @PUT("getForgottenPassword")
    @FormUrlEncoded
    Observable<String> getForgottenPassword(@Field("email") String email);

    @GET("GetGameList")
    @FormUrlEncoded
    Observable<String> GetGameList(@Field("idUser") int idUser);


    @GET("GetGamesNbr")
    @FormUrlEncoded
    Observable<String> getGamesNbr(@Field("idUser") String idUser);

    @GET("GetFavouriteGamesNbr")
    @FormUrlEncoded
    Observable<String> getFavouriteGamesNbr(@Field("idUser") String idUser);

    @GET("GetWishGamesNbr")
    @FormUrlEncoded
    Observable<String> getWishGamesNbr(@Field("idUser") String idUser);


}
