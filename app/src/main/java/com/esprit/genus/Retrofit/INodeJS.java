package com.esprit.genus.Retrofit;

import com.esprit.genus.Model.Game;

import java.util.List;

import io.reactivex.Observable;
import retrofit2.Call;
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

    @PUT("/editProfile")
    @FormUrlEncoded
    Observable<String> editProfile(@Field("username") String username,@Field("password") String password);


    @GET("GetGameList/{idUser}")

    Observable<List<Game>> GetGameList(@Path("idUser") int idUser);


    @GET("GetGameList/{idUser}")

    Call<List<Game>> GetGameListForNumber(@Path("idUser") int idUser);
    //this one for gamesNumber okay ?

    @GET("GetWishList/{idUser}")
    Call<List<Game>> GetWishList(@Path("idUser") int idUser);

    @GET("GetFavList/{idUser}")
    Call<List<Game>> GetFavList(@Path("idUser") int idUser);


}
