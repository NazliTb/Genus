package com.esprit.genus;

import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BlurMaskFilter;
import android.os.Bundle;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import com.bumptech.glide.Glide;
import com.bumptech.glide.load.Transformation;
import com.bumptech.glide.request.RequestOptions;
import com.esprit.genus.Model.Game;
import com.esprit.genus.Retrofit.INodeJS;
import com.esprit.genus.Retrofit.RetrofitClient;
import com.jgabrielfreitas.core.BlurImageView;

import java.util.List;

import io.reactivex.disposables.CompositeDisposable;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

import static com.bumptech.glide.request.RequestOptions.bitmapTransform;

public class GamescreenActivity extends AppCompatActivity {

    INodeJS myAPI, myAPI1;
    CompositeDisposable compositeDisposable = new CompositeDisposable();

    private String idGame = "";
    private ImageView gameImg;
    BlurImageView gameBg;
    private TextView gameName, studioName, favNbr, cmtNbr, gameDesc;


    @Override
    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        setContentView(R.layout.gamescreen_layout);

        //Get game ID
        Intent intent = getIntent();
        if (intent != null) {

            if (intent.hasExtra("idGame")) {
                idGame = intent.getStringExtra("idGame");
            }
        }

        //verify that we got the game ID
        Toast.makeText(this, "idGame: " + idGame, Toast.LENGTH_SHORT).show();

        //Init API
        Retrofit retrofit = RetrofitClient.getInstance();
        myAPI = retrofit.create((INodeJS.class));

        Retrofit retrofit1 = new Retrofit.Builder()
                .baseUrl("http://10.0.2.2:3000/")
                .addConverterFactory(GsonConverterFactory.create())
                .build();
        myAPI1 = retrofit1.create((INodeJS.class));
        final Call <List<Game>> myGame = myAPI1.GetGameDetails(Integer.parseInt(idGame));

        //our views
        gameImg = (ImageView) findViewById(R.id.gameImg);
        gameBg = (BlurImageView) findViewById(R.id.gameBg);
        gameName = (TextView) findViewById(R.id.gameName);
        studioName = (TextView) findViewById(R.id.gameStudio);
        favNbr = (TextView) findViewById(R.id.favCount);
        cmtNbr = (TextView) findViewById(R.id.cmCount);
        gameDesc = (TextView) findViewById(R.id.gameDesc);

        //display our informations
        myGame.enqueue(new Callback <List<Game>>() {
            @Override
            public void onResponse(Call <List<Game>> call, Response <List<Game>> response) {
                if (!response.isSuccessful()) {
                    return;
                }
                List<Game> gameDetails = response.body();
                int cpt=0;
                for (Game g:gameDetails) {
                    gameName.setText(g.getName());
                    studioName.setText("by "+g.getCompanyName());
                    gameDesc.setText(g.getDescription());
                    Glide.with(GamescreenActivity.this)
                            .load("http://10.0.2.2:3000/image/"+g.getGamePicture())
                            .into(gameImg);
                    Glide.with(GamescreenActivity.this)
                            .load("http://10.0.2.2:3000/image/"+g.getGamePicture())
                            .into(gameBg);
                }
            }

            @Override
            public void onFailure(Call <List<Game>> call, Throwable t) {
                Toast.makeText(GamescreenActivity.this, "Not found" , Toast.LENGTH_SHORT).show();
            }
        });

        gameBg.setBlur(10);

    }
}