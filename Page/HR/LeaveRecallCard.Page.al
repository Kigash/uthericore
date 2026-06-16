page 50435 "Leave Recall Card"
{
    // version TL2.0

    DeleteAllowed = false;
    PageType = Card;
    SourceTable = 50222;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Recall Date"; Rec."Recall Date")
                {
                    ApplicationArea = All;
                }
                field("Leave Application"; Rec."Leave Application")
                {
                    NotBlank = true;
                    ApplicationArea = All;
                }
                field("Employee No"; Rec."Employee No")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Caption = 'Employee Name';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Employee Department"; Rec."Employee Department")
                {
                    Caption = 'Department';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Employee Branch"; Rec."Employee Branch")
                {
                    Caption = 'Branch';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Employee Job Title"; Rec."Employee Job Title")
                {
                    Caption = 'Job Title';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Leave Start Date"; Rec."Leave Start Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Days Applied"; Rec."Days Applied")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Leave Ending Date"; Rec."Leave Ending Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Remaining Days"; Rec."Remaining Days")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group("Recall Details")
            {
                Caption = 'Recall Details';
                field("Recalled Days"; Rec."Recalled Days")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Recalled From"; Rec."Recalled From")
                {
                    ApplicationArea = All;
                }
                field("Recalled To"; Rec."Recalled To")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Recalled By"; Rec."Recalled By")
                {
                    NotBlank = true;
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Recall Department"; Rec."Recall Department")
                {
                    Caption = 'Department.';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Recall Branch"; Rec."Recall Branch")
                {
                    Caption = 'Branch.';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
                {
                    Caption = 'Job Title.';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Reason for Recall"; Rec."Reason for Recall")
                {
                    NotBlank = true;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Recall & Notify Employee")
            {
                Caption = 'Recall Employee';
                Image = Email;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    IF CONFIRM(TEXT001) THEN BEGIN
                        Rec.Testfield("Leave Application");
                        Rec.TestField("Employee No");
                        Rec.Testfield("Leave Ending Date");
                        Rec.TestField("Recalled From");
                        Rec.Testfield("Recalled To");
                        Rec.TestField("Recalled By");
                        Rec.Testfield("Reason for Recall");
                        Rec.TestField("Recall Date");

                        HRJournalLine.INIT;
                        HRJournalLine."Document No" := Rec."No.";
                        HRJournalLine."Leave Period" := FORMAT(DATE2DMY(TODAY, 3));
                        HRJournalLine."Employee No." := Rec."Employee No";
                        HRJournalLine."Employee Name" := Rec."Employee Name";
                        HRJournalLine."Posting Date" := TODAY;
                        HRJournalLine."Entry Type" := HRJournalLine."Entry Type"::Positive;
                        HRJournalLine.Description := Rec."Reason for Recall";
                        HRJournalLine."Leave Code" := Rec."Leave Code";
                        HRJournalLine.Days := Rec."Recalled Days";
                        HRJournalLine."User ID" := USERID;
                        HRJournalLine.Recall := TRUE;
                        HRJournalLine.INSERT(TRUE);

                        Rec.Status := Rec.Status::Released;
                        Rec.MODIFY();

                        IF Employee.GET(Rec."Employee No") THEN BEGIN
                            IF UserSetup.GET(USERID) THEN BEGIN
                                HRSetup.GET;
                                CompanyInformation.GET;
                                RecipientMail := Employee."E-Mail" + ';' + UserSetup."E-Mail" + ';' + HRSetup."HR E-Mail";
                                /* HRManagement.SendMail(RecipientMail,TEXT002,TEXT003+"Employee Name"+TEXT004+"Leave Code"+TEXT005+Name+TEXT006+
                                                       FORMAT("Recalled Days")+TEXT007+FORMAT("Recalled From")+TEXT008+FORMAT("Recalled To")+TEXT009+CompanyInformation.Name);*/
                                MESSAGE(TEXT010);
                            END;
                        END;
                    END;

                end;
            }
        }
    }

    var
        HRJournalLine: Record 50209;
        TEXT001: Label 'Recall Employee from Leave?';
        HRManagement: Codeunit 50050;
        UserSetup: Record 91;
        Employee: Record 5200;
        RecipientMail: Text;
        HRSetup: Record 5218;
        TEXT002: Label 'LEAVE RECALL NOTICE';
        TEXT003: Label '"Dear  "';
        TEXT004: Label '",<br><br> Please note that your "';
        TEXT005: Label '" leave has been recalled by "';
        TEXT006: Label '" for "';
        TEXT007: Label '" days from "';
        TEXT008: Label '" to "';
        TEXT009: Label '. <br><br>Kind Regards,<br>';
        CompanyInformation: Record 79;
        TEXT010: Label 'Employee has been successfully recalled!';
}
