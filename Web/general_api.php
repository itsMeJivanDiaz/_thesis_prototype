<?php

require 'db.php';

header('Content-Type:application/json');

if(isset($_GET['all'])){

    $stmt = mysqli_stmt_init($conn);

    $sql_select = "SELECT * FROM establishment ORDER BY est_name ASC";

    $sql_join = "SELECT * FROM establishment INNER JOIN location ON establishment.est_loc_ID = location.loc_loc_ID INNER JOIN account ON account.acc_acc_ID = establishment.est_acc_ID
    INNER JOIN count_info ON count_info_ID = est_count_info_ID WHERE est_loc_ID = ? AND est_acc_ID = ? AND est_count_info_ID = ?;";

    $json_data = array();

    if(!mysqli_stmt_prepare($stmt, $sql_select)){
        echo json_encode(array(
            'Response_message' => 'Something went wrong'
        ));
    }else{
        mysqli_stmt_execute($stmt);
        $result = mysqli_stmt_get_result($stmt);
        while($row = mysqli_fetch_assoc($result)){
            $loc_id = $row['est_loc_ID'];
            $acc_id = $row['est_acc_ID'];
            $count_id = $row['est_count_info_ID'];
            if(!mysqli_stmt_prepare($stmt, $sql_join)){
                echo json_encode(array(
                    'Response_message' => 'Something went wrong'
                ));
            }else{
                mysqli_stmt_bind_param($stmt, 'sss', $loc_id, $acc_id, $count_id);
                mysqli_stmt_execute($stmt);
                $res = mysqli_stmt_get_result($stmt);
                while($row = mysqli_fetch_assoc($res)){
                    $array = array(
                        'establishment-name' => $row['est_name'],
                        'establishment-type' => $row['est_type'],
                        'city' => $row['loc_city'],
                        'branch-street' => $row['loc_branch_str'],
                        'barangay-area' => $row['loc_brgy'],
                        'latitude' => $row['loc_lat'],
                        'longitude' => $row['loc_long'],
                        'allowed-capacity' => $row['count_allowable_capacity'],
                        'normal-capacity' => $row['count_normal_capacity'],
                        'available-capacity' => $row['count_available'],
                        'current-crowd' => $row['count_current'],
                        'limited-capacity' => $row['count_normal_capacity'] * $row['count_allowable_capacity'],
                        'establishment-ID' => $row['est_ID'],
                        'location-ID' => $row['loc_loc_ID'],
                        'account-ID' => $row['acc_acc_ID'],
                    );
                    array_push($json_data,  $array);
                }
            }
        }
        echo json_encode($json_data, JSON_PRETTY_PRINT);
    }
}else{
    echo 'butsog';
}
?>