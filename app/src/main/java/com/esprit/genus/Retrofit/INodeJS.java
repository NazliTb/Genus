package com.esprit.genus.Retrofit;

import io.reactivex.Observable;
import retrofit2.http.Field;
import retrofit2.http.FormUrlEncoded;
import retrofit2.http.GET;
import retrofit2.http.POST;
import retrofit2.http.PUT;
import retrofit2.http.Path;

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

    @GET("GetGameList/{idUser}")

    Observable<String> GetGameList(@Path("idUser") int idUser);



    @GET("GetGamesNbr/{idUser}")

    String getGamesNbr(@Path("idUser") String idUser);

    @GET("GetFavouriteGamesNbr/{idUser}")

    Observable<String> getFavouriteGamesNbr(@Path("idUser") String idUser);

    @GET("GetWishGamesNbr/{idUser}")

    Observable<String> getWishGamesNbr(@Path("idUser") String idUser);


}
