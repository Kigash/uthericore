page 50978 "Receive File Card"
{
    // version TL2.0

    PageType = Card;
    SourceTable = "File Movement";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Received; Rec.Received)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("File Movement ID"; Rec."File Movement ID")
                {
                    ApplicationArea = All;
                }
                field("File No."; Rec."File No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("File Number"; Rec."File Number")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = All;
                }
                field("ID No"; Rec."ID No")
                {
                    ApplicationArea = All;
                }
                field("Payroll No"; Rec."Payroll No")
                {
                    ApplicationArea = All;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Cabinet No."; Rec."Cabinet No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Volume; Rec.Volume)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("From Location"; Rec."From Location")
                {
                    ApplicationArea = All;
                    Caption = 'From Branch';
                    Editable = false;
                }
                field("To Location"; Rec."To Location")
                {
                    ApplicationArea = All;
                    Caption = 'To Branch';
                    Editable = false;
                }
                field("Request Remarks"; Rec."Request Remarks")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Approval/Rejection Remarks"; Rec."Approval/Rejection Remarks")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Approved Date"; Rec."Approved Date")
                {
                    ApplicationArea = All;
                }
                field("Approver ID"; Rec."Approver ID")
                {
                    ApplicationArea = All;
                }
                field("Released By"; Rec."Released By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Released To"; Rec."Released To")
                {
                    ApplicationArea = All;
                }
                field("Carried By"; Rec."Carried By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Date Released"; Rec."Date Released")
                {
                    ApplicationArea = All;
                }
                field("Received By"; Rec."Received By")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Receive File")
            {
                ApplicationArea = All;
                Image = ReceivableBill;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction();
                begin
                    RegistryManagement.ReceiveFile(Rec);
                    CurrPage.CLOSE;
                end;
            }
        }
    }

    var
        FilesMvt: Record "File Movement";
        User: Record "User Setup";
        //smtprec : Record "409";
        //smtpcu : Codeunit "400";
        bddialog: Dialog;
        mailheader: Text;
        mailbody: Text;
        RegisterLines: Record "Registry Files Line";
        RegistrySetUp: Record "Registry SetUp";
        //Cust: Record "18";
        //NoSetup : Record "50011";
        NoSeriesMgt: Codeunit "No. Series";noseries: Record "No. Series";
        ChangeApproved: Boolean;
        SendRequest: Boolean;
        TransferFilesLines: Record "Registry Files Line";
        //MemberAgencies : Record "50018";
        //DimensionValue : Record "349";
        Location: Code[50];
        CurrentYear: Integer;
        BranchNumberSeries: Code[50];
        FileStatus: Code[40];
        RegistryFileStatus: Record "Registry File Status";
        RegFileDesc: Text[50];
        RegistryFiles: Record "Registry File";
        branch: Code[50];
        // DimensionValue1 : Record "349";
        branchname: Text[20];
        branchName2: Text;
        RegistryManagement: Codeunit "Registry Management2";
}

