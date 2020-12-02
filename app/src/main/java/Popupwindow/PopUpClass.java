package Popupwindow;

import android.content.Intent;
import android.provider.ContactsContract;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.PopupWindow;
import android.widget.TextView;
import android.widget.Toast;

import com.esprit.genus.HomepageActivity;
import com.esprit.genus.LoginActivity;
import com.esprit.genus.ProfileActivity;
import com.esprit.genus.R;
import com.esprit.genus.Retrofit.INodeJS;
import com.esprit.genus.Retrofit.RetrofitClient;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.CompositeDisposable;
import io.reactivex.functions.Consumer;
import io.reactivex.schedulers.Schedulers;
import retrofit2.Retrofit;

public class PopUpClass {

    //PopupWindow display method
    INodeJS myAPI;
    CompositeDisposable compositeDisposable = new CompositeDisposable();
    EditText username;
    EditText password;
    EditText cPassword;
    Button updateProfile;
    public String idUser;

    public void showPopupWindow(final View view) {

        //Init API
        Retrofit retrofit = RetrofitClient.getInstance();
        myAPI = retrofit.create((INodeJS.class));

        //Create a View object yourself through inflater
        LayoutInflater inflater = (LayoutInflater) view.getContext().getSystemService(view.getContext().LAYOUT_INFLATER_SERVICE);
        View popupView = inflater.inflate(R.layout.popupwindow, null);

        //Specify the length and width through constants
        int width = 1000;//LinearLayout.LayoutParams.MATCH_PARENT;
        int height = 1000;//LinearLayout.LayoutParams.MATCH_PARENT;

        //Make Inactive Items Outside Of PopupWindow
        boolean focusable = true;

        //Create a window with our parameters
        final PopupWindow popupWindow = new PopupWindow(popupView, width, height, focusable);

        //Set the location of the window on the screen
        popupWindow.showAtLocation(view, Gravity.CENTER, 0, 0);

        //Initialize the elements of our window, install the handler

        username = (EditText) popupView.findViewById(R.id.editusername);
        password = (EditText) popupView.findViewById(R.id.editpassword);
        cPassword = (EditText) popupView.findViewById(R.id.editcpassword);

        updateProfile = popupView.findViewById(R.id.updateProfile_button);
        updateProfile.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                updateUser(idUser,username.getText().toString(), password.getText()
                        .toString());


            }
        });



        //Handler for clicking on the inactive zone of the window

        popupView.setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View v, MotionEvent event) {

                //Close the window when clicked
                popupWindow.dismiss();
                return true;
            }
        });
    }

    private void updateUser(String idUser,String username, String password) {


        compositeDisposable.add(myAPI.editProfile(Integer.parseInt(idUser),username, password)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(new Consumer<String>() {
                    @Override
                    public void accept(String s) throws Exception {
                        System.out.println(s);
                        }


                    }));

                }


    }


