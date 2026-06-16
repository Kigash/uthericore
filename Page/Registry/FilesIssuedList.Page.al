page 55718 "Files Issued List"
{
    // version CBS-TL,REG

    CardPageID = "Release File Card";
    PageType = List;
    SourceTable = "Issued Registry File";

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
            action("Generate Acknowledgement Receipt")
            {
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction();
                begin
                    FilesIssued.RESET;
                    FilesIssued.SETRANGE("Request Status", FilesIssued."Request Status"::Issued);
                    FilesIssued.SETRANGE("Request ID", Rec."Request ID");
                    REPORT.RUN(51223, TRUE, FALSE, FilesIssued);
                    //FilesIssued.Picked:=TRUE;
                    //FilesIssued.Issued:=TRUE;
                    //FilesIssued.MODIFY;
                end;
            }
        }
    }

    trigger OnOpenPage();
    begin
        CurrPage.EDITABLE(FALSE);
    end;

    var
        Picked: Boolean;
        FilesIssued: Record "File Issuance";
        FilesIssuedList: Page "Files Issued List";
        Requestlines: Record "Registry Files Line";
}

