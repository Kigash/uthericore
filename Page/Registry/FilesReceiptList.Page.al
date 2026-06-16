page 55709 "Files Receipt List"
{
    // version CBS-TL,REG

    CardPageID = "Confirm Receipt of Files";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Issued Registry File";
    SourceTableView = WHERE("Confirm Receipt" = CONST(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Picked; Picked)
                {
                    Visible = false;

                    trigger OnValidate();
                    begin
                        FilesIssued.SETRANGE("Request Status", FilesIssued."Request Status"::Issued);
                        FilesIssued.SETRANGE("Request ID", Rec."Request ID");
                        Requestlines.SETRANGE("Request ID", Rec."Request ID");
                        REPORT.RUN(51223, TRUE, FALSE, FilesIssued);
                    end;
                }
                field("Request ID"; Rec."Request ID")
                {
                }
                field("Request Date"; Rec."Request Date")
                {
                }
                field("Requisiton By"; Rec."Requisiton By")
                {
                }
                field("Issuer ID"; Rec."Issuer ID")
                {
                }
                field("Issued Date"; Rec."Issued Date")
                {
                }
                field("Lines Request ID"; Requestlines."Request ID")
                {
                    Visible = false;

                    trigger OnValidate();
                    begin
                        Requestlines.SETRANGE("Request ID", FilesIssued."Request ID");
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
        }
    }

    trigger OnOpenPage();
    begin
        User.GET(USERID);
        Rec.FILTERGROUP(2);
        Rec.SETRANGE("Requisiton By", USERID);
        Rec.FILTERGROUP(0);
    end;

    var
        Picked: Boolean;
        FilesIssued: Record "File Issuance";
        FilesIssuedList: Page "Files Issued List";
        Requestlines: Record "Registry Files Line";
        User: Record "User Setup";
}

