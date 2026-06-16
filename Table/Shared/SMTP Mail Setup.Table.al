table 50001 "SMTP Mail Setup"
{
    Caption = 'SMTP Mail Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Server Address"; Text[100]) { Caption = 'Server Address'; }
        field(2; "Port"; Integer) { Caption = 'Port'; }
        field(3; "Use SSL"; Boolean) { Caption = 'Use SSL'; }
        field(4; "User ID"; Text[100]) { Caption = 'User ID'; }
        field(5; "Sender Name"; Text[100]) { Caption = 'Sender Name'; }
        field(6; "Sender Email Address"; Text[250]) { Caption = 'Sender Email Address'; }
    }
}
